module.exports = class GameAction
  constructor: ({@dispatcher, @socket, @gameState}) ->

  sync: (target) ->
    target ?= @socket
    target.emit "sync", @gameState.players, @gameState.bullets

  playerShoot: (id, playerId, from, to, timestamp, broadcast = no) ->
    @dispatcher.emit 'bullets.create', id, playerId
    @dispatcher.emit 'bullets.bullet-move', id, from, to, timestamp
    @dispatcher.emit 'players.player-shoot', playerId, from, to, timestamp

  playerMove: (id, from, to, timestamp, broadcast = no) ->
    @dispatcher.emit 'players.player-move', id, from, to, timestamp
    if broadcast
      @socket.emit "playerMove", id, from, to, timestamp

  playerDie: (id, who) ->
    @dispatcher.emit 'players.player-die', id
  
  playerLeave: (id) ->
    @dispatcher.emit 'players.player-leave', id

  playerJoin: (id, position, timestamp, broadcast = no) ->
    @dispatcher.emit 'players.create', id
    @dispatcher.emit 'players.player-move', id, position, position, timestamp

    if broadcast
      @socket.emit "playerJoin", id, position, timestamp
