const db = require('../../utils/db');
const bcrypt = require('bcrypt');
const salt = bcrypt.genSaltSync(12);
const transporter = require('../../utils/mail');
const {v4:uuidv4} = require('uuid');
var localSessionId;

const getLogin = (req,res) =>{
    if(req.session.session_id == localSessionId && (localSessionId != undefined && req.session.session_id != undefined))
        res.redirect('/scholars/dashboard');
    else
        res.render('../views/scholars/login.pug',{title: 'Sign In as Scholar',message:''});
}

const postLogin = async(req,res) => {
    try{
        const results = await db.query('SELECT scholar_id,scholar_email,scholar_password FROM scholar WHERE scholar_email = $1',[req.body.username]);
        console.log(results);
        if(results.rows.length > 0)
        {
            var username = results.rows[0]['scholar_email'];
            var hash = results.rows[0]['scholar_password'];
            var scholar_id = results.rows[0]['scholar_id'];
            if(req.body.username == username && await bcrypt.compareSync(req.body.password,hash))
            {
                req.session.user=scholar_id;
                req.session.email=req.body.username;
                req.session.session_id = uuidv4();
                req.session.user_type = 'scholars';
                localSessionId = req.session.session_id;
                res.redirect('/scholars/dashboard');
            }
            else 
            res.render('../views/scholars/login',{title: 'Sign In as Scholar',message: "Your email or password is incorrect"});
        }
        else
        {
            res.render('../views/scholars/login',{title: 'Sign In as Scholar',message: "This user does not exist"})
        }  
    }
    catch(err)
    {
        console.log(err);
    }
}
const getSignUp = async(req,res) =>{
    guide_list = await showAllGuides();
    res.render('../views/scholars/signup',{title: 'Sign Up as Scholar',guides:guide_list});
}

const postSignUp = async(req,res)=>{
    try
    {
      var hash = await bcrypt.hashSync(req.body.password,salt);
      var results = await db.query('INSERT INTO SCHOLAR (scholar_email,scholar_password,scholar_guide_id) values ($1,$2,$3) RETURNING *',[req.body.username,hash,req.body.guide]);
      try 
      {
        req.session.user=results.rows[0].scholar_id;
        req.session.email = results.rows[0].scholar_email;
        req.session.session_id = uuidv4();
        req.session.user_type = 'scholars';
        localSessionId = req.session.session_id;
        res.redirect('/scholars/register');
      }
      catch(err)
      {
          console.log(err);
      }
    }
  
    catch(err)
    {
      console.log(err);
    }
}

const getRegistration = async(req,res) =>{
    if(req.session.session_id == localSessionId)
    {
      college_list = await showAllColleges();
      department_list = await showAllDepartments();
      res.render('../views/scholars/register.pug',{college: college_list,department: department_list});
    }
    else 
    {
        res.send("Error 404: Not Logged In");
    }
}

const postRegistration = async(req,res) => {
    if(req.session.session_id == localSessionId)
    {
      try 
      {
          console.log(req.body);
          console.log(req.session);
          var results = await db.query('UPDATE SCHOLAR SET scholar_name=$1, scholar_phone=$2, scholar_usn=$3, scholar_college_id=$5, scholar_department_id=$6, is_scholar_registered=true WHERE scholar_id=$4 RETURNING *',[req.body.name,req.body.phone,req.body.usn,req.session.user,req.body.college,req.body.department]);
          try 
          { 
              sendScholarMail(req.session.email,"Thank you for registering on Researchbase!",`Dear ${req.body.name}, \nThank you for registering on Researchbase. Hope you have a great experience.`);
              // send notification mail to guide to approve the scholar.
          }
          catch(err)
          {
              console.log(err);
          }    
          res.redirect('/scholars/dashboard');
      }
      catch(err)
      {
          console.log(err);
      }
    }
    else 
    {
        res.send("Invalid Operation");
    }
}
const dashboard = async(req,res) => {
    //const guideName = await getGuideNamebyScholarId(req.session.id);
    if(req.session.session_id == localSessionId)
      {
        const results = await db.query('SELECT is_scholar_registered FROM SCHOLAR WHERE scholar_id=$1',[req.session.user]);
        const profile = await db.query("SELECT * FROM SCHOLAR WHERE SCHOLAR_ID=$1",[req.session.user]);
        if(results.rows[0].is_scholar_registered == true )
          res.render('../views/scholars/dashboard.pug',{user:req.session.user,profile:profile.rows[0]});
        else 
          res.redirect('/scholars/register');
      }
      else {
        console.log(req.session.user);
        res.status(404).send("Unauthorized Access");
      }
    }
  
const viewSchedules = async(req,res) => 
{
    if(req.session.session_id == localSessionId)
    {
        console.log(req.session.user);
        const schedules = await showAllSchedulesbyScholarId(req.session.user);
        res.render('../views/scholars/schedule/view.pug',{schedule_list: schedules});
    }
    else 
    {
        res.status(404).send("Unauthorized Access");
    }
} 
const logout = (req,res) =>{
    req.session.destroy((err)=>{
        if(err)
        {
          console.log(err);
        }
        else 
        {
          localSessionId = 00000000-0000-0000-0000-000000000000;             
          res.redirect('/');
        }
      });
}

const showAllGuides = async() =>{
    const guides = await db.query("SELECT guide_id,guide_name FROM GUIDES");
    return guides.rows;
}

const showAllColleges = async() => {
    const colleges = await db.query("SELECT college_id,college_name FROM COLLEGE");
    return colleges.rows;
}
const showAllDepartments = async() => {
    const colleges = await db.query("SELECT department_id,department_name FROM DEPARTMENT");
    return colleges.rows;
}
const showAllSchedulesbyScholarId = async(scholar_id) => {
    const results = await db.query("SELECT * FROM SCHEDULE WHERE SCHOLAR_ID=$1 AND IS_CANCELLED=false",[scholar_id]);
    //console.log(results.rows);
    return results.rows;
}
const getGuideNamebyScholarId = async(guide_id) => {
    const guide_email = await db.query("SELECT GUIDES.GUIDE_NAME FROM GUIDES, SCHOLAR WHERE GUIDES.GUIDE_ID=SCHOLAR.SCHOLAR_GUIDE_ID",[guide_id]);
    //console.log(guide_email.rows[0]);
    return guide_email.rows[0];
}

function sendScholarMail (to,subject,body)
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

module.exports = {
    getLogin, getSignUp, postLogin, getRegistration, postSignUp, postRegistration, logout, dashboard, viewSchedules
}