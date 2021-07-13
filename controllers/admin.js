const express = require('express');
const db = require('../utils/db');

const login = async(req,res)=>{
    res.render('../views/admin/login',{title: "Sign In"});
}

const postLogin = (req,res)=> {
    try {
        if(req.body.username == "admin@researchbase" && req.body.password == "admin")
        {
            req.session.user = req.body.username;
            res.redirect('/admin/dashboard');
        }    
    }
    catch(err)
    {
        console.log(err);
    }
}
const dashboard = async(req,res)=>{
    if(req.session.user)
    {
        res.render('../views/admin/dashboard',{user:'admin'});
    }
    else 
    {
        res.send("Operation Invalid")
    }
}
const logout = async(req,res) => {
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


const scholarDeleteGet = (req,res) =>{
    res.render('../views/admin/scholars/delete')
}



module.exports = { login, postLogin,scholarDeleteGet,dashboard, logout };