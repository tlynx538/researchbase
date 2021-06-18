const express = require('express');
const db = require('../db');

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
        //console.log(req.params.id);
        //console.log(err);
        res.status(501).json({
            "status":res.statusCode,
            "response":err
        });
    } 
}


module.exports = {
    getScholars, postScholar, getScholarById, delScholar
}