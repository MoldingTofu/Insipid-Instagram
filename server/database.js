var sqlite3 = require('sqlite3').verbose()

var db = new sqlite3.Database('./photos.db', sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE, (err) => {
  if (err) {
    return console.error(err.message);
  }

  console.log('Connected to the in-memory SQlite Database.');
});

db.run("CREATE TABLE IF NOT EXISTS photos(" +
    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
    ");",
    function(err) {
      if (err)
        throw err;
      console.log("Created table if it didn't exist already")
    });

module.exports = db;
