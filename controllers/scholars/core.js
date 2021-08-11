const db = require('../../utils/db');
const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT is_scholar_registered FROM SCHOLAR WHERE scholar_email=$1',[req.session.user]);
      if(results.rows[0].is_scholar_registered == true )
        res.render('../views/scholars/dashboard.pug',{user:req.session.user});
      else 
        res.redirect('/scholars/register');
    }
    else {
      console.log(req.session.user);
      res.send("Error: Unauthorized User!");
    }
  }
module.exports = {
    dashboard
}  