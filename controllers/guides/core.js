const db = require('../../utils/db');
const transporter = require('../../utils/mail');

const dashboard = async(req,res) => {
    const guideName = await getGuideName(req.session.user);
    if(req.session.user)
    {
      const results = await db.query('SELECT admin_approve,is_guide_registered FROM guides WHERE guide_id=$1',[req.session.user]);
      const profile = await db.query("SELECT * FROM GUIDES WHERE GUIDE_ID=$1",[req.session.user]);
      if(results.rows[0].is_guide_registered == true )
        res.render('../views/guides/dashboard.pug',{user:guideName.guide_name,profile:profile.rows[0]});
      else 
        res.redirect('/guides/register');
    }

    else {
      console.log(req.session.user);
      res.status(404).send("Unauthorized Access");
    }
  }

const getScholars = async(req,res) =>
{
  try 
  {
    const results = await db.query("SELECT * FROM SCHOLAR WHERE GUIDE_APPROVE=true AND SCHOLAR_GUIDE_ID=$1",[req.session.user]);
    console.log(results.rows);
    res.render('../views/guides/scholar/view.pug',{scholars_list:results.rows});
  }
  catch(err)
  {
    console.log(err);
    res.status(500).send(err);
  }
}


const getApprove = async(req,res) => {
    scholars = await showAllScholarsbyGuideNotApprove(req.session.user);
    res.render('../views/guides/scholar/approve',{scholars_list: scholars});
}  

const postApprove = async(req,res) => {
  try
  {
    const results = await db.query('UPDATE SCHOLAR SET GUIDE_APPROVE=true WHERE SCHOLAR_GUIDE_ID=$1 AND SCHOLAR_ID=$2',[req.session.user,req.params.id]);
    res.redirect('/guides/approve');
  }
  catch(err)
  {
    console.log(err);
    res.status(500).send(err);
  } 
  const guideName = await getGuideName(req.session.user);
  const scholarDetails = await getScholarNameEmail(req.session.user,req.params.id);
  sendMail(scholarDetails.scholar_email,`You have been approved by your guide`,`Dear ${scholarDetails.scholar_name},\nYour Guide ${guideName.guide_name} has approved you to use Researchbase.\nHope you have a great experience!`); 
}

const viewSchedule = async(req,res) => {
  if(req.session.user)
  {
    schedule_list = await showAllScheduleswithScholarNames(req.session.user);
    res.render('../views/guides/schedule/view',{schedule_list:schedule_list});
  }
  else 
  {
    res.status(401)
  }
}

const getSchedule = async(req,res) =>{
  if(req.session.user)
  {
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list: scholars,message:''});
  }
  else 
    res.status(401);
}

const postSchedule = async(req,res) =>{
  try
  {
    const results = db.query('INSERT INTO schedule(name_of_event,guide_id,scholar_id,date_of_event,time_of_event,body) values($1,$2,$3,$4,$5,$6)',[req.body.eventName,req.session.user,req.body.student,req.body.dateEvent,req.body.timeEvent,req.body.eventDesc]);
  }
  catch(err)
  {
    console.log(err);
    res.status(500).send(err);
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"There was a problem adding your schedule, please check if you have entered correctly"});
  }
  try
  {
    const scholarDetails = await getScholarNameEmail(req.session.user,req.body.student);
    const guide = await getGuideName(req.session.user);
    const guide_email = await getGuideEmail(req.session.user);
    sendMail(scholarDetails.scholar_email,`"${req.body.eventName}" has been assigned to you`,`Hello ${scholarDetails.scholar_name}, \nYour Guide Dr.${guide.guide_name}, has scheduled an event\n\nEvent Name: "${req.body.eventName}".\nEvent Description: ${req.body.eventDesc} \nPlease login to your profile to check the same.`);
    sendMail(guide_email,`"${req.body.eventName}" has been assigned by you`,`Dear Dr. ${guide.guide_name}, \nYou scheduled an event\nEvent Name: "${req.body.eventName}".\nEvent Description: ${req.body.eventDesc}\nAssigned to: ${scholarDetails.scholar_name} \nPlease login to your profile to check the same.`);
  }
  catch(err)
  {
    console.log(err);
    res.status(500).send(err);
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"There was a problem sending mail."});
  }
  scholars = await showAllScholars(req.session.user);
  res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"Your schedule has been added"});
}


const cancelSchedulebyId = async(req,res) =>{
  if(req.session.user)
  {
    try
    {
      const results = await db.query('UPDATE SCHEDULE SET is_cancelled=true WHERE schedule_id=$1',[req.params.id]);
    }
    catch(err)
    {
      console.log(err);
      res.status(500).send(err);
    }
    
    const guide_email = await getGuideEmail(req.session.user);
    const deletedScheduleDetails = await scheduleEventName(req.params.id);
    console.log(deletedScheduleDetails);
    sendMail(guide_email,`Event "${deletedScheduleDetails.name_of_event}" has been cancelled`,`Your event ${deletedScheduleDetails.name_of_event} has been cancelled successfully`);
    sendMail(deletedScheduleDetails.scholar_email,`Event "${deletedScheduleDetails.name_of_event}" has been cancelled`,`Your guide has cancelled an event ${deletedScheduleDetails.name_of_event}`);
    res.redirect('/guides/schedule/view');
  } 
}

const getProfile = async(req,res) =>{
  if(req.session.user)
  {
    const scholar = await showScholarDetailsById(req.session.user,req.params.id);
    console.log(scholar);
    res.render('../views/guides/scholar/profile',{scholar_list:scholar});
  }
  else 
  {
    res.status(401);
  }
}





// API Related Functions
const getScholarNameEmail = async(guide_id,scholar_id) => {
  const results = await db.query("SELECT SCHOLAR_NAME, SCHOLAR_EMAIL FROM SCHOLAR WHERE SCHOLAR_GUIDE_ID=$1 AND SCHOLAR_ID=$2",[guide_id,scholar_id]);
  return results.rows[0];
}

const getGuideName = async(guide_id) => {
  const guide_email = await db.query("SELECT GUIDE_NAME FROM GUIDES WHERE GUIDE_ID=$1",[guide_id]);
  //console.log(guide_email.rows[0]);
  return guide_email.rows[0];
}

const getGuideEmail = async(guide_id) => {
  const guide_email = await db.query("SELECT GUIDE_EMAIL FROM GUIDES WHERE GUIDE_ID=$1",[guide_id]);
  //console.log(guide_email.rows[0]);
  return guide_email.rows[0].guide_email;
}

const showAllScholars = async(guide_id) => {
  const scholar = await db.query("SELECT * FROM SCHOLAR WHERE SCHOLAR_GUIDE_ID=$1 AND GUIDE_APPROVE=true",[guide_id]);
  //console.log(scholar.rows);
  return scholar.rows;
}

const showScholarDetailsById = async(guide_id,scholar_id) =>{
  const scholar = await db.query("SELECT SCHOLAR.SCHOLAR_NAME,SCHOLAR.SCHOLAR_EMAIL,SCHOLAR.SCHOLAR_PHONE,SCHOLAR.SCHOLAR_USN,COLLEGE.COLLEGE_NAME,DEPARTMENT.DEPARTMENT_NAME FROM SCHOLAR,DEPARTMENT,COLLEGE WHERE SCHOLAR_ID=$1 AND SCHOLAR.SCHOLAR_COLLEGE_ID=COLLEGE.COLLEGE_ID AND SCHOLAR.SCHOLAR_DEPARTMENT_ID=DEPARTMENT.DEPARTMENT_ID AND SCHOLAR_GUIDE_ID=$2 AND GUIDE_APPROVE=true",[scholar_id,guide_id]);
  return scholar.rows[0];
}

const showAllScholarsbyGuideNotApprove = async(guide_id) => {
  const scholar = await db.query("SELECT SCHOLAR.SCHOLAR_ID, SCHOLAR.SCHOLAR_NAME FROM SCHOLAR WHERE SCHOLAR.SCHOLAR_GUIDE_ID=$1 AND SCHOLAR.GUIDE_APPROVE=false",[guide_id]);
  //console.log(scholar.rows);
  return scholar.rows;
}

const showAllScheduleswithScholarNames = async(guide_id) => {
    const schedules = await db.query("SELECT SCHOLAR.SCHOLAR_NAME, SCHOLAR.SCHOLAR_EMAIL, SCHEDULE.SCHEDULE_ID, SCHEDULE.NAME_OF_EVENT, SCHEDULE.DATE_OF_EVENT, SCHEDULE.TIME_OF_EVENT, SCHEDULE.BODY FROM SCHOLAR, SCHEDULE WHERE SCHEDULE.GUIDE_ID=$1 AND SCHEDULE.SCHOLAR_ID=SCHOLAR.SCHOLAR_ID AND SCHEDULE.IS_CANCELLED=false",[guide_id]);
    //console.log(schedules.rows);
    return schedules.rows;
}


const scheduleEventName = async(schedule_id) => {
  const resultEventName = await db.query("SELECT SCHEDULE.NAME_OF_EVENT, SCHEDULE.SCHOLAR_ID,SCHOLAR.SCHOLAR_ID, SCHOLAR.SCHOLAR_EMAIL FROM SCHEDULE, SCHOLAR WHERE SCHEDULE_ID=$1 AND SCHEDULE.SCHOLAR_ID=SCHOLAR.SCHOLAR_ID",[schedule_id]);
  return resultEventName.rows[0]
}

// Mail Functions
function sendMail (to,subject,body)
{
    var mailOptions =
    {
        from: 'mail.researchbase@gmail.com',
        to: to,
        subject: subject,
        text: body
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      }); 
}


module.exports = {dashboard,getApprove,getScholars,postApprove,viewSchedule,getSchedule,postSchedule,cancelSchedulebyId,getProfile};  