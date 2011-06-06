
fs = require("fs")

irc = require("irc")
express = {createServer} = require "express"

settings = JSON.parse fs.readFileSync "config.json"

client = new irc.Client settings.server, settings.nick,
  channels: settings.channels


client.on "message", (from, to, message) ->
  console.log from + " => " + to + ": " + message


app = createServer express.bodyParser()


app.get "/", (req, res) ->
  res.send "IRCPost"


app.post "/#{ settings.path }", (req, res) ->
  console.log "posting", req.body
  client.say req.body.channel, req.body.msg
  res.end "hello world"


app.listen settings.listenPort

console.log "Listening post request on
  0.0.0.0:#{ settings.listenPort }:/#{ settings.path }"
