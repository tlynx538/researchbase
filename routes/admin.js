const express = require('express');
const router = express.Router();
const adminControllers = require('../controllers/admin');
router.get('/',adminControllers.login);
router.post('/login',adminControllers.postLogin);
//router.get('/dashboard',adminControllers.dashboard);
router.get('/logout',adminControllers.logout);

module.exports = router;