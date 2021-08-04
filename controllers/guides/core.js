const db = require('../../utils/db');

const dashboard = async(req,res) => {
    if(req.session.user)
    {
      const results = await db.query('SELECT admin_approve,is_guide_registered FROM guides WHERE guide_id=$1',[req.session.user]);
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

const approve = async(req,res) => {
    scholars = await showAllScholarsbyGuideNotApprove(req.session.user);
    res.render('../views/guides/scholar/approve',{scholars_list: scholars});
}  

const postApprove = async(req,res) => {
  try
  {
    const results = await db.query('UPDATE SCHOLAR SET GUIDE_APPROVE=true WHERE SCHOLAR_GUIDE_ID=$1 AND SCHOLAR_ID=$2',[req.session.user,req.params.id]);
    res.redirect('/guides/approve');
  }
  catch(err)
  {
    console.log(err);
  } 
}

const showAllScholarsbyGuideNotApprove = async(guide_id) => {
  console.log("Guide ID:"+guide_id);
  const scholar = await db.query("SELECT * FROM SCHOLAR WHERE SCHOLAR_GUIDE_ID=$1 AND GUIDE_APPROVE=false",[guide_id]);
  console.log(scholar.rows);
  return scholar.rows;
}

module.exports = {dashboard,approve,postApprove};  