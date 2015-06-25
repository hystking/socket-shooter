{indexOf} = require "lodash"
express = require "express"
app = express()
server = (require "http").createServer app
io = (require "socket.io") server

GameDispatcher = require "./src/coffee/dispatchers/game"
GameState = require "./src/coffee/stores/game-state"
GameAction = require "./src/coffee/actions/game"

gameDispatcher = new GameDispatcher
gameState = new GameState
  dispatcher: gameDispatcher
gameAction = new GameAction
  dispatcher: gameDispatcher
  socket: io.to "lobby"

io.on "connection", (socket) ->
  console.log "joinee"
  _id = -1

  socket.join "lobby"

  socket.on "playerJoin", (id, position, timestamp) ->
    _id = id
    gameAction.playerJoin id, position, timestamp

  socket.on "playerMove", (id, from, to, timestamp) ->
    gameAction.playerMove id, from, to, timestamp, yes

  socket.on "disconnect", ->
    console.log "disconnect", _id
    gameAction.playerLeave _id

  socket.emit "init"

setInterval ->
  console.log "players:", gameState.players.map (p) -> p.id
  io.emit "sync", gameState.players, gameState.bullets
, 1000

app.use express.static "debug"
server.listen 3000
