{find, findIndex, last} = require 'lodash'
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

    @dispatcher.on 'players.player-move', (id, from, to, timestamp) =>
      player = find @players, id: id
      return unless player?
      from = calcMove player.state.moves, timestamp unless from?
      move =
        from: from
        to: to
        speed: player.speed
        timestamp: timestamp
      player.state.moves.push move

    @dispatcher.on 'players.player-leave', (id) =>
      @players.splice (findIndex @players, id: id), 1

    @dispatcher.on 'players.player-die', (id, timestamp) =>
      player = find @players, id: id
      die =
        timestamp: timestamp
      player.state.dies.push die

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
      dies: []
  
  _createBullet: (id, playerId) ->
    id: id
    playerId: playerId
    speed: .5
    state:
      moves: []
