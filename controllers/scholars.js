const express = require('express');
const db = require('../utils/db');
const bcrypt = require('bcrypt');
const salt = bcrypt.genSaltSync(12);
const transporter = require('../utils/mail');

const login = (req,res) =>{
    res.render('../views/scholars/login.pug',{title: 'Sign In as Scholar'});
}

const postLogin = async(req,res) => {
    try{
        const results = await db.query('SELECT scholar_email,scholar_password FROM scholar WHERE scholar_email = $1',[req.body.username]);
        var username = results.rows[0]['scholar_email'];
        var hash = results.rows[0]['scholar_password'];
        if(req.body.username == username && await bcrypt.compareSync(req.body.password,hash))
        {
          req.session.user=req.body.username;
          res.redirect('/scholars/dashboard');
        }
        else 
          res.redirect('/scholars/login');  
    }
    catch(err)
    {
        console.log(err);
    }
}

const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT is_scholar_registered FROM SCHOLAR WHERE scholar_email=$1',[req.session.user]);
      if(results.rows[0].is_scholar_registered == false )
      {
          res.redirect('/scholars/register');
      }
      else 
      {
        res.render('../views/scholars/dashboard.pug',{user:req.session.user});
      }
    }
    else {
      console.log(req.session.user);
      res.send("Error: Unauthorized User!");
    }
  }
  const getRegistration = (req,res) =>{
      if(req.session.user)
      {
        res.render('../views/scholars/register.pug');
      }
      else 
      {
          res.send("Error 404: Not Logged In");
      }
  }
  const postRegistration = async(req,res) => {
      if(req.session.user)
      {
        try 
        {
            var results = await db.query('UPDATE SCHOLAR SET scholar_name=$1, scholar_phone=$2, scholar_usn=$3, is_scholar_registered=true WHERE scholar_email=$4',[req.body.name,req.body.phone,req.body.usn,req.session.user]);
            try 
            { 
                sendScholarMail(req.session.user,"Thank you for registering on Researchbase!",`Dear ${req.body.name}, \nThank you for registering on Researchbase. Hope you have a great experience.`);
            }
            catch(err)
            {
                console.log(err);
            }    
            res.redirect('/scholar/dashboard');
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

const signUp = (req,res) =>{
    res.render('../views/scholars/signup',{title: 'Sign Up as Scholar'});
}

const postSignUp = async(req,res)=>{
    try
    {
      var hash = await bcrypt.hashSync(req.body.password,salt);
      var results = await db.query('INSERT INTO SCHOLAR (scholar_email,scholar_password) values ($1,$2) RETURNING *',[req.body.username,hash]);
      res.send("User Created!");
    }
  
    catch(err)
    {
      console.log(err);
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
          res.redirect('/');
        }
      });
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










// API Requests
const getScholars = async(req,res)=>{
    try
    {
        const results = await db.query('SELECT * FROM SCHOLAR');
        res.status(200).json({
            "status": res.statusCode,
            "scholar_details": results.rows
        });
    }
    catch(err)
    {
        res.status(501).json({
            "status":res.statusCode,
            "message":err
        });
    }

}

const postScholar = async(req,res)=>{
    try 
    {
        const results = await db.query('INSERT INTO SCHOLAR (SCHOLAR_NAME,SCHOLAR_EMAIL,SCHOLAR_PASSWORD, SCHOLAR_PHONE, SCHOLAR_GUIDE_ID) values ($1,$2,$3,$4,$5) RETURNING *',[req.body.scholar_name,req.body.scholar_email,req.body.scholar_phone,req.body.scholar_password,req.body.scholar_guide_id]);
        res.status(200).json({
            "status": res.status,
            "response": results.rows[0]
        });
    }
    catch(err)
    {
        res.status(501).json({
            "status":res.status,
            "response":err
        });
    }
}

const getScholarById = async(req,res) =>{
    try
    {
        const results = await db.query('SELECT * FROM SCHOLAR WHERE SCHOLAR_ID = $1',[req.params.id])
        res.status(200).json({
            "status": res.statusCode,
            "scholar_details": results.rows[0]
        });
    }
    catch(err)
    {
        res.status(501).json({
            "status":res.statusCode,
            "response":err
        });
    }
}

const delScholar = async(req,res)=>{
    try {
        const results = await db.query('DELETE FROM SCHOLAR WHERE SCHOLAR_ID = $1 RETURNING *',[req.params.id]);
        res.status(410).json({
            "status": res.statusCode,
            "response":results.rows
        });
    }
    catch(err)
    {
        res.status(501).json({
            "status":res.statusCode,
            "response":err
        });
    } 
}


module.exports = {
    getScholars, dashboard ,getRegistration,postRegistration,login, signUp, postSignUp, logout, postLogin,postScholar, getScholarById, delScholar
}