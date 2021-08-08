const express = require('express');
const db = require('../utils/db');
const {v4:uuidv4} = require('uuid');
var localSessionId;
const login = async(req,res)=>{
    res.render('../views/admin/login',{title: "Sign In"});
}

const postLogin = (req,res)=> {
    try {
        if(req.body.username == "admin@researchbase" && req.body.password == "admin")
        {
            req.session.user = req.body.username;
            req.session.session_id = uuidv4();
            localSessionId = req.session.session_id;
            res.redirect('/admin/dashboard');
        }    
    }
    catch(err)
    {
        console.log(err);
    }
}
const dashboard = async(req,res)=>{
    if(req.session.session_id = localSessionId)
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
          localSessionId = 00000000-0000-0000-0000-000000000000;  
          res.redirect('/');
        }
      });
}

showAllScholars = async() => {
    const results = await db.query("SELECT * FROM SCHOLAR");
    console.log(results.rows);
    return results.rows;
}

const scholarDeleteGet = async(req,res) =>{
    results = await showAllScholars();
    res.render('../views/admin/scholars/delete',{results: results})
}

module.exports = { login, postLogin,scholarDeleteGet,dashboard, logout };