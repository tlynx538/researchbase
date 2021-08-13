const db = require('../../utils/db');

const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT is_scholar_registered FROM SCHOLAR WHERE scholar_id=$1',[req.session.user]);
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

const viewSchedules = async(req,res) => 
{
    if(req.session.user)
    {
      const schedules = await showAllSchedulesbyScholarId(req.session.user);
      res.render('../views/scholars/schedule/view.pug',{schedule_list: schedules});
    }
} 

const showAllSchedulesbyScholarId = async(scholar_id) =>{
  const results = await db.query("SELECT * FROM SCHEDULE WHERE SCHOLAR_ID=$1 AND IS_CANCELLED=false",[scholar_id]);
  console.log(results.rows);
  return results.rows;
}

module.exports = {
    dashboard, viewSchedules
}  