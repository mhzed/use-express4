express = require('express');
path = require('path');

logger = require('morgan');
methodOverride = require('method-override');
bodyParser = require('body-parser');
multer = require('multer');
errorHandler = require('errorhandler');
compression = require("compression")
app = express();

app.use(logger('dev'));
app.use(methodOverride());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(multer());
app.use(compression());

# development only
if ('development' == app.get('env'))
  app.use(errorHandler());

module.exports = {

  express : express,

  initAppFunc : (app, express)->
  ,

  # launch(3000, ()-> console.log("started"))
  launch : (port, host, postLaunchCb)->
    app.set('port', port);
    module.exports.initAppFunc(app, express)
    app.listen(port, host, ()->
      console.log('Express server listening on port ' + port);
      if postLaunchCb then postLaunchCb()
    )
  ,

  launchLocalDev : (postLaunchCb)->
    findport = require "find-free-port"
    open = require "open"

    findport(10000, 10100, '127.0.0.1', (err, port)->
      module.exports.launch(port, '127.0.0.1', ()->
        console.log "Launching browser window"
        open("http://localhost:" + port);
      )
    )

}