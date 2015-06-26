express = require "express"
app = express()
server = (require "http").createServer app
io = (require "socket.io") server

GameServer = require "./game-server"

gameServer = new GameServer
  room: io.to "lobby"

app.use express.static "debug"
server.listen 3000
