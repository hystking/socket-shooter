{indexOf} = require "lodash"

GameDispatcher = require "./src/coffee/dispatchers/game"
GameState = require "./src/coffee/stores/game-state"
GameAction = require "./src/coffee/actions/game"
GameServerClient = require "./game-server-client"

module.exports = class GameServer
  constructor: ({@room}) ->
    @idMaster = 0
    @gameDispatcher = new GameDispatcher
    @gameState = new GameState
      dispatcher: @gameDispatcher
    @gameAction = new GameAction
      dispatcher: @gameDispatcher
      socket: @room

    @room.on "connection", @_onConnection

    @startSync()

  startSync: ->
    setInterval @_sync, 10000

  _sync: =>
    console.log "players:", @gameState.players.map (p) -> p.id
    @gameAction.sync @gameState

  _onConnection: (socket) =>
    @idMaster += 1
    console.log "join", @idMaster
    serverClient = new GameServerClient
      id: @idMaster
      gameAction: @gameAction
      socket: socket
    @_sync()
