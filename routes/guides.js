const express = require('express');
const router = express.Router();
const guideControllers = require('../controllers/guides/auth')
const guideCore = require('../controllers/guides/core')

router.get('/login',guideControllers.login);
router.get('/signup',guideControllers.signUp);
router.post('/signup',guideControllers.postSignUp);
router.get('/login',guideControllers.login);
router.get('/register',guideControllers.getRegistration);
router.post('/register',guideControllers.postRegistration);
router.post('/login',guideControllers.postLogin);
router.get('/logout',guideControllers.logout);

router.get('/dashboard',guideCore.dashboard);
router.get('/view',guideCore.getScholars);

router.get('/schedule/create',guideCore.getSchedule);
router.post('/schedule/create',guideCore.postSchedule);
router.get('/schedule/view',guideCore.viewSchedule);
router.get('/schedule/cancel/:id',guideCore.cancelSchedulebyId);

router.get('/approve',guideCore.getApprove);
router.get('/approve/:id',guideCore.postApprove);


router.get('/profile/:id',guideCore.getProfile);
//router.get('/',guideControllers.getGuides);
//router.get('/:id',guideControllers.getGuideById);
//router.post('/',guideControllers.postGuides);
router.delete('/delete/:id',guideControllers.delGuide);
module.exports = router;
