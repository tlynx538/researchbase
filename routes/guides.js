const express = require('express');
const router = express.Router();
const guideControllers = require('../controllers/guides')
router.get('/',guideControllers.getGuides);
router.get('/:id',guideControllers.getGuideById);
router.post('/',guideControllers.postGuides);
router.delete('/delete/:id',guideControllers.delGuide);
module.exports = router;
