{find, findIndex, last, remove} = require 'lodash'
calcMove = require '../utils/calc-move'

module.exports = class GameState extends require 'events'
  constructor: ({@players, @bullets, @dispatcher}) ->
    @players ?= []
    @bullets ?= []

    @dispatcher.on 'bullets.create', (id, playerId, from, to, timestamp) =>
      @bullets.push @_createBullet id, playerId
    
    @dispatcher.on 'bullets.bullet-move', (id, from, to, timestamp) =>
      bullet = find @bullets, id: id
      from = calcMove bullet.state.moves, timestamp unless from?
      move =
        from: from
        to: to
        speed: bullet.speed
        timestamp: timestamp
      bullet.state.moves.push move

    @dispatcher.on 'players.player-move', (id, from, to, timestamp, overwrite = no) =>
      player = find @players, id: id
      return unless player?
      sameTimestampMove = find player.state.moves, timestamp: timestamp
      from = calcMove player.state.moves, timestamp unless from?
      if sameTimestampMove?
        return unless overwrite
        sameTimestampMove.from = from
        sameTimestampMove.to = to
        sameTimestampMove.speed = player.speed
        sameTimestampMove.timestamp = timestamp
        return
      move =
        from: from
        to: to
        speed: player.speed
        timestamp: timestamp
      player.state.moves.push move
      player.state.moves.sort (a, b) -> a.timestamp - b.timestamp

    @dispatcher.on 'players.player-leave', (id) =>
      remove @players, (player) -> player.id is id

    @dispatcher.on 'players.player-damage', (id, damageObjectId, timestamp) =>
      player = find @players, id: id
      damage =
        timestamp: timestamp
        damageObjectId: damageObjectId
      player.state.damages.push damage
    
    @dispatcher.on 'players.player-clear-damage', (id, damageObjectId) =>
      # This player does not damage by the damageObject!
      player = find @players, id: id
      damages = where player.state.damages damageObjectId: damageObjectId
      remove player.state.damages, (damage) -> contains damages, damage

    @dispatcher.on 'players.player-shoot', (id, from, to, timestamp) =>
      player = find @players, id: id
      shoot =
        from: from
        to: to
        timestamp: timestamp
      player.state.shoots.push shoot

    @dispatcher.on 'players.create', (id) =>
      return if (find @players, id: id)?
      @players.push @_createPlayer id

  _createPlayer: (id) ->
    id: id
    speed: .1
    state:
      moves: []
      shoots: []
      damages: []
  
  _createBullet: (id, playerId) ->
    id: id
    playerId: playerId
    speed: .5
    state:
      moves: []
