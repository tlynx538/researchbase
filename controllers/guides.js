const express = require('express');
const db = require('../utils/db');


const login = (req,res)=>{
    res.render('../views/guides/login', {title: 'Sign In as Guide'})
}

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


module.exports = {
    login, getGuides, postGuides, getGuideById, delGuide
}