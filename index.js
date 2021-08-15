require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const app = express();
const port = process.env.port || 8000;
const {v4:uuidv4} = require('uuid');
const guideRoutes = require('./routes/guides');
const scholarRoutes = require('./routes/scholars');
const adminRoutes = require('./routes/admin');

app.set('view engine','pug');
app.use(express.json());
app.use(express.urlencoded({ extended:false }));
app.use(cookieParser());
app.use(morgan('combined'));
app.use(session({
    secret:uuidv4(),
    resave: false,
    saveUninitialized: true
  }))


app.use(express.static('public'))
//uses the route /guide for performing CRUD operations on Guides
app.use('/guides/',guideRoutes);
//uses this route /scholars for performing CRUD operations on Scholars
app.use('/scholars/',scholarRoutes);
//uses the route /admin for administrative purpose 
app.use('/admin/',adminRoutes); 
//shows the main page of the application
app.get('/',function(req,res){
    res.render('index');
});
app.get('/devs',(req,res)=>{
    res.render('developers');
})

//telling the server to listen on a specific port.
app.listen(port, function(req,res){
    console.log(`The app is listening on http://localhost:${port}`);
})