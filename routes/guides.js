const express = require('express');
const router = express.Router();
const guideControllers = require('../controllers/guides/guides')


router.get('/login',guideControllers.login);
router.get('/signup',guideControllers.signUp);
router.post('/signup',guideControllers.postSignUp);
router.get('/login',guideControllers.login);
router.get('/register',guideControllers.getRegistration);
router.post('/register',guideControllers.postRegistration);
router.post('/login',guideControllers.postLogin);
router.get('/logout',guideControllers.logout);

router.get('/dashboard',guideControllers.dashboard);
router.get('/view',guideControllers.getScholars);

router.get('/schedule/create',guideControllers.getSchedule);
router.post('/schedule/create',guideControllers.postSchedule);
router.get('/schedule/view',guideControllers.viewSchedule);
router.get('/schedule/cancel/:id',guideControllers.cancelSchedulebyId);

router.get('/approve',guideControllers.getApprove);
router.get('/approve/:id',guideControllers.postApprove);


router.get('/profile/:id',guideControllers.getProfile);
//router.get('/',guideControllers.getGuides);
//router.get('/:id',guideControllers.getGuideById);
//router.post('/',guideControllers.postGuides);
//router.delete('/delete/:id',guideControllers.delGuide);
module.exports = router;
