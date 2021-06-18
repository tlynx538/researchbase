const express = require('express');
const router = express.Router();
const scholarControllers = require('../controllers/scholars')
router.get('/',scholarControllers.getScholars);
router.get('/:id',scholarControllers.getScholarById);
router.post('/',scholarControllers.postScholar);
router.delete('/delete/:id',scholarControllers.delScholar);
module.exports = router;
