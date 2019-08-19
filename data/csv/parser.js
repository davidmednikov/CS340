fs = require('fs')
fs.readFile('/Users/dmednikov/Desktop/School/OSU/340/project/data/csv/flights.csv', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  console.log(data);
});
