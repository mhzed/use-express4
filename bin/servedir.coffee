
argv = require 'yargs'
.usage '''
Usage: $0 -p [port] -d [directory_path]
'''
.alias 'p', 'port'
.describe 'port', 'specify local port to listen on, or use ip:port to listen on specific ip/port'
.alias 'd', 'dir'
.describe 'dir', 'specify the root www local dir'
.alias 'b', 'browse'
.describe 'browse', 'launch local browser to open the page'
.help 'h'
.argv


parseOpts = (cb)->
  opts = {
  }
  opts.dir = argv.dir
  opts.dir ?= process.cwd()

  if argv.port
    if /\:/.test argv.port
      [opts.ip, opts.port] = argv.port.split ':'
    else
      opts.port = argv.port
    cb opts
  else
    require('find-free-port') 9900, (err, _p)->
      opts.port = _p
      cb opts

parseOpts (opts)->
  require("../").initAppFunc = (app, express)->
    app.use(express.static(opts.dir));

  require("../").launch opts.port, opts.ip, ()->
    if argv.b
      url = "http://localhost:" + opts.port
      console.log "Browsing to #{url}"
      open = require "open"
      open url

