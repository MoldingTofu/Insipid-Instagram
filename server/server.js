var sqlite = require('sqlite3').verbose();
var express = require('express');
var bodyparser = require('body-parser');
var app = express();

var db = require('./database.js');

app.use(bodyparser.urlencoded({ extended: true }));
app.use(bodyparser.json());

app.use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type, cache-control');
    return next();
});

var port = 8000;
var router = express.Router();

router.use(function(req, res, next) {
  console.log('server in use');
  next();
});

app.use('/', router);
server = app.listen(port);
console.log('Express server listening on port %d in %s mode.', port, app.settings.env);
