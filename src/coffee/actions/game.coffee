module.exports = class GameAction
  constructor: ({@dispatcher}) ->

  playerShoot: (id, playerId, from, to, timestamp) ->
    @dispatcher.emit 'bullets.create', id, playerId
    @dispatcher.emit 'bullets.bullet-move', id, from, to, timestamp
    @dispatcher.emit 'players.player-shoot', playerId, from, to, timestamp

  playerMove: (id, from, to, timestamp) ->
    @dispatcher.emit 'players.player-move', id, from, to, timestamp

  playerDie: (id, who) ->
    @dispatcher.emit 'players.player-die', id

  playerJoin: (id, position, timestamp) ->
    @dispatcher.emit 'players.create', id
    @dispatcher.emit 'players.player-move', id, position, position, timestamp

