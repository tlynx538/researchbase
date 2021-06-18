require('dotenv').config();
const express = require('express');
const morgan = require('morgan');

const app = express();
const port = process.env.port || 8000;
const guideRoutes = require('./routes/guides')
const scholarRoutes = require('./routes/scholars')
app.set('view engine','pug');
app.use(express.json());
app.use(morgan('tiny'));

//uses the route /guide for performing CRUD operations on Guides
app.use('/guides/',guideRoutes);
//uses this route /scholars for performing CRUD operations on Scholars
app.use('/scholars/',scholarRoutes);

//shows the main page of the application
app.get('/',function(req,res){
    res.render('index');
});

//telling the server to listen on a specific port.
app.listen(port, function(req,res){
    console.log(`The app is listening on http://localhost:${port}`);
})