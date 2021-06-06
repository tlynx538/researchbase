require('dotenv').config();
let express = require('express');
let morgan = require('morgan');
let path = require('path');
let app = express();
let port = process.env.port || 8000;
let db = require('./db');

app.set('view engine','pug');
app.use(express.json());
app.use(morgan('tiny'));

//main page
app.get('/',function(req,res){
    res.render('index');
});


//needs to be moved to controllers soon..
//get all guides from database
app.get('/api/v1/guides',async(req,res)=>{
    try{
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
        })
    }

});

//add guides to database
app.post('/api/v1/guides',async(req,res)=>{
    try 
    {
        const results = await db.query('INSERT INTO GUIDES (GUIDE_NAME,GUIDE_EMAIL,GUIDE_PHONE) values ($1,$2,$3) RETURNING *',[req.body.guide_name,req.body.guide_email,req.body.guide_phone]);
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
});


//get guides by id
app.get('/api/v1/guides/:id',async(req,res)=>{
    const results = await db.query('SELECT * FROM GUIDES WHERE GUIDE_ID = $1',[req.params.id])
    res.status(200).json({
        "status": res.statusCode,
        "guide_details": results.rows[0]
    })
});

//delete guide by id
app.delete('/api/v1/guides/:id',async(req,res)=>{
    try {
        const results = await db.query('DELETE FROM GUIDES WHERE GUIDE_ID = $1 RETURNING *',[req.params.id]);
        res.status(410).json({
            "status": res.statusCode,
            "response":results.rows
        });
    }
    catch(err)
    {
        console.log(req.params.id);
        console.log(err);
        res.status(501).json({
            "status":res.statusCode,
            "response":err
        });
    }    

})



app.listen(port, function(req,res){
    console.log(`The app is listening on http://localhost:${port}`);
})