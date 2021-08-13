const db = require('../../utils/db');
const transporter = require('../../utils/mail');
const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT admin_approve,is_guide_registered FROM guides WHERE guide_id=$1',[req.session.user]);
      if(results.rows[0].is_guide_registered == true )
        res.render('../views/guides/dashboard.pug',{user:req.session.user});
      else 
        res.redirect('/guides/register');
    }

    else {
      console.log(req.session.user);
      res.send("Error: Unauthorized User!");
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
  } 
}

const viewSchedule = async(req,res) => {
  if(req.session.user)
  {
    schedule_list = await showAllScheduleswithScholarNames(req.session.user);
    res.render('../views/guides/schedule/view',{schedule_list:schedule_list});
  }
  else 
  {
    res.send("Unauthorized Access");
  }
}

const getSchedule = async(req,res) =>{
  if(req.session.user)
  {
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list: scholars,message:''});
  }
  else 
    res.send("Unauthorized Action");
}

const postSchedule = async(req,res) =>{
  try
  {
    const results = db.query('INSERT INTO schedule(name_of_event,guide_id,scholar_id,date_of_event,time_of_event,body) values($1,$2,$3,$4,$5,$6)',[req.body.eventName,req.session.user,req.body.student,req.body.dateEvent,req.body.timeEvent,req.body.eventDesc]);
  }
  catch(err)
  {
    console.log(err);
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"There was a problem adding your schedule, please check if you have entered correctly"});
  }
  try
  {
    const scholarDetails = await getScholarNameEmail(req.session.user,req.body.student);
    console.log(scholarDetails);
    const guide = await getGuideName(req.session.user);
    sendMail(scholarDetails.scholar_email,`"${req.body.eventName}" has been assigned to you`,`Hello ${scholarDetails.scholar_name}, \nYour Guide Dr.${guide.guide_name}, has scheduled an event\n\nEvent Name: "${req.body.eventName}".\nEvent Description: ${req.body.eventDesc} \nPlease login to your profile to check the same.`);
  }
  catch(err)
  {
    console.log(err);
    scholars = await showAllScholars(req.session.user);
    res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"There was a problem sending mail."});
  }
  scholars = await showAllScholars(req.session.user);
  res.render('../views/guides/schedule/create',{scholar_list:scholars,message:"Your schedule has been added"});
}



const getScholarNameEmail = async(guide_id,scholar_id) => {
  const results = await db.query("SELECT SCHOLAR_NAME, SCHOLAR_EMAIL FROM SCHOLAR WHERE SCHOLAR_GUIDE_ID=$1 AND SCHOLAR_ID=$2",[guide_id,scholar_id]);
  return results.rows[0];
}

const getGuideName = async(guide_id) => {
  const guide_email = await db.query("SELECT GUIDE_NAME FROM GUIDES WHERE GUIDE_ID=$1",[guide_id]);
  console.log(guide_email.rows[0]);
  return guide_email.rows[0];
}

const showAllScholars = async(guide_id) => {
  const scholar = await db.query("SELECT * FROM SCHOLAR WHERE SCHOLAR_GUIDE_ID=$1",[guide_id]);
  console.log(scholar.rows);
  return scholar.rows;
}

const showAllScholarsbyGuideNotApprove = async(guide_id) => {
  const scholar = await db.query("SELECT SCHOLAR.SCHOLAR_ID, SCHOLAR.SCHOLAR_NAME FROM SCHOLAR WHERE SCHOLAR.SCHOLAR_GUIDE_ID=$1 AND SCHOLAR.GUIDE_APPROVE=false",[guide_id]);
  console.log(scholar.rows);
  return scholar.rows;
}

const showAllScheduleswithScholarNames = async(guide_id) => {
    const schedules = await db.query("SELECT SCHOLAR.SCHOLAR_NAME, SCHOLAR.SCHOLAR_EMAIL, SCHEDULE.SCHEDULE_ID, SCHEDULE.NAME_OF_EVENT, SCHEDULE.DATE_OF_EVENT, SCHEDULE.TIME_OF_EVENT, SCHEDULE.BODY FROM SCHOLAR, SCHEDULE WHERE SCHEDULE.GUIDE_ID=$1 AND SCHEDULE.SCHOLAR_ID=SCHOLAR.SCHOLAR_ID AND SCHEDULE.IS_CANCELLED=false",[guide_id]);
    console.log(schedules.rows);
    return schedules.rows;
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
        res.send(err);
      }
      res.redirect('/guides/schedule/view');
    } 
}



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


module.exports = {dashboard,getApprove,postApprove,viewSchedule,getSchedule,postSchedule,cancelSchedulebyId};  