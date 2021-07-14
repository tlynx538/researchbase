const express = require('express');
const router = express.Router();
const guideControllers = require('../controllers/guides')
router.get('/login',guideControllers.login);
router.get('/signup',guideControllers.signUp);
router.post('/signup',guideControllers.postSignUp);
router.get('/login',guideControllers.login);
router.get('/register',guideControllers.getRegistration);
router.post('/register',guideControllers.postRegistration);
router.get('/dashboard',guideControllers.dashboard);
router.post('/login',guideControllers.postLogin);
router.get('/logout',guideControllers.logout);


//router.get('/',guideControllers.getGuides);
//router.get('/:id',guideControllers.getGuideById);
//router.post('/',guideControllers.postGuides);
router.delete('/delete/:id',guideControllers.delGuide);
module.exports = router;
