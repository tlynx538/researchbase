const express = require('express');
const router = express.Router();

const authControllers = require('../controllers/scholars/auth')
const coreControllers = require('../controllers/scholars/core')
router.get('/signup',authControllers.getSignUp);
router.post('/signup',authControllers.postSignUp);
router.get('/login',authControllers.getLogin);
router.post('/login',authControllers.postLogin);
router.get('/logout',authControllers.logout);
router.get('/register',authControllers.getRegistration);
router.post('/register',authControllers.postRegistration);

router.get('/dashboard',coreControllers.dashboard);

module.exports = router;
