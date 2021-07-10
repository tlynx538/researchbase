const express = require('express');
const db = require('../db');

const login = async(req,res)=>{
    res.render('../views/admin/login',{title: "Sign In"});
}

const postLogin = (req,res)=> {
    try {
        if(req.body.username == "admin@researchbase" && req.body.password == "admin")
        {
            req.session.user = req.body.username;
            res.render('../views/admin/dashboard',{user:'admin'});
        }    
    }
    catch(err)
    {
        console.log(err);
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
module.exports = { login, postLogin, logout };