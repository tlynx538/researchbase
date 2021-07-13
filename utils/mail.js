const nodemailer = require('nodemailer');
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'mail.researchbase@gmail.com',
      pass: 'jC77yttk!MDb'
    }
  });
module.exports = transporter;