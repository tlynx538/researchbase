const express = require('express');
const router = express.Router();
const scholarControllers = require('../controllers/scholars')
router.get('/signup',scholarControllers.signUp);
router.post('/signup',scholarControllers.postSignUp);
router.get('/login',scholarControllers.login);
router.get('/register',scholarControllers.getRegistration);
router.post('/register',scholarControllers.postRegistration);
router.get('/dashboard',scholarControllers.dashboard);
router.post('/login',scholarControllers.postLogin);
router.get('/logout',scholarControllers.logout);

// API Routes
router.get('/',scholarControllers.getScholars);
router.get('/:id',scholarControllers.getScholarById);
router.post('/',scholarControllers.postScholar);
router.get('/delete/:id',scholarControllers.delScholar);
module.exports = router;
