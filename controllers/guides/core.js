const db = require('../../utils/db');

const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT admin_approve,is_guide_registered FROM guides WHERE guide_email=$1',[req.session.user]);
      console.log(results.rows[0]);
      if(results.rows[0].is_guide_registered == true )
        res.render('../views/guides/dashboard.pug',{user:req.session.user});
      else 
        res.redirect('/guides/register');
    }

    else {
      console.log(req.session.user);
      res.send("Error: Unauthorized User!");
    }
  }

  

module.exports = {dashboard};  