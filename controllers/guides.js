const express = require('express');
const db = require('../utils/db');
const bcrypt = require('bcrypt');
const salt = bcrypt.genSaltSync(12);
const transporter = require('../utils/mail');

const login = (req,res) => {
    res.render('../views/guides/login.pug',{title: 'Sign In as Guide',message: ''});
}

const postLogin = async(req,res) => {
    try{
        const results = await db.query('SELECT guide_email,guide_password FROM guides WHERE guide_email = $1',[req.body.username]);
        if(results.rows.length >0)
        {
            var username = results.rows[0]['guide_email'];
            var hash = results.rows[0]['guide_password'];
            if(req.body.username == username && await bcrypt.compareSync(req.body.password,hash))
            {
                req.session.user=req.body.username;
                res.redirect('/guides/dashboard');
            }
            else 
                res.render('../views/guides/login.pug',{title: 'Sign In as Guide',message: "Your email or password is incorrect"});
        }
        else 
            res.render('../views/guides/login.pug',{title: 'Sign In as Guide',message: "This user does not exist"}); 
    }
    catch(err)
    {
        console.log(err);
    }
}

const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT admin_approve FROM guides WHERE guide_email=$1',[req.session.user]);
      if(results.rows[0].is_guide_registered == false )
      {
          res.redirect('/guides/register');
      }
      else 
      {
        res.render('../views/guides/dashboard.pug',{user:req.session.user});
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
        res.render('../views/guides/register.pug');
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
            var results = await db.query('UPDATE guides SET guide_name=$1, guide_phone=$2, guide_usn=$3,is_guide_registered=true WHERE guide_email=$4',[req.body.name,req.body.phone,req.body.usn,req.session.user]);
            try 
            { 
                sendGuidesMail(req.session.user,"Thank you for registering on Researchbase!",`Dear ${req.body.name}, \nThank you for registering on Researchbase. Hope you have a great experience.`);
            }
            catch(err)
            {
                console.log(err);
            }    
            res.redirect('/guides/dashboard');
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
    res.render('../views/guides/signup',{title: 'Sign Up as Guide'});
}

const postSignUp = async(req,res)=>{
    try
    {
      var hash = await bcrypt.hashSync(req.body.password,salt);
      var results = await db.query('INSERT INTO guides (guide_email,guide_password) values ($1,$2) RETURNING *',[req.body.username,hash]);
      req.session.user=req.body.username;
      res.redirect('/guides/register');
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


// API Routes
const getGuides = async(req,res)=>{
    try
    {
        const results = await db.query('SELECT * FROM GUIDES');
        res.status(200).json({
            "status": res.statusCode,
            "guide_details": results.rows
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

const postGuides = async(req,res)=>{
    try 
    {
        const results = await db.query('INSERT INTO GUIDES (GUIDE_NAME,GUIDE_EMAIL,GUIDE_PHONE, GUIDE_PASSWORD) values ($1,$2,$3,$4) RETURNING *',[req.body.guide_name,req.body.guide_email,req.body.guide_phone,req.body.guide_password]);
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

const getGuideById = async(req,res) =>{
    try
    {
        const results = await db.query('SELECT * FROM GUIDES WHERE GUIDE_ID = $1',[req.params.id])
        res.status(200).json({
            "status": res.statusCode,
            "guide_details": results.rows[0]
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

const delGuide = async(req,res)=>{
    try {
        const results = await db.query('DELETE FROM GUIDES WHERE GUIDE_ID = $1 RETURNING *',[req.params.id]);
        res.status(410).json({
            "status": res.statusCode,
            "response":results.rows
        });
    }
    catch(err)
    {
        //console.log(req.params.id);
        //console.log(err);
        res.status(501).json({
            "status":res.statusCode,
            "response":err
        });
    } 
}
function sendGuidesMail (to,subject,body)
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
    getGuides, dashboard ,getRegistration,postRegistration,login, signUp, postSignUp, logout, postLogin, getGuides, postGuides, getGuideById, delGuide
}