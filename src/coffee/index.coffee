socket = require "./utils/socket"
{clone} = require "lodash"

GameDispatcher = require './dispatchers/game'
GameState = require './stores/game-state'
GameAction = require './actions/game'
GameComponent = require './components/game'
Renderer = require './utils/renderer'

gameDispatcher = new GameDispatcher
gameState = new GameState
  dispatcher: gameDispatcher
gameAction = new GameAction
  dispatcher: gameDispatcher
  socket: socket
gameComponent = new GameComponent

renderer = new Renderer 100, 100, transparent: true
gameDom.appendChild renderer.view

setInterval ->
  time = Date.now()
  gameComponent.update time, gameState
  renderer.render gameComponent.pixiObject
, 16

playerId = Math.random() * 10000 | 0

onClick = (e) ->
  gameAction.playerMove playerId, null, {x: e.clientX, y: e.clientY}, Date.now(), yes

onResize = ->
  renderer.resize renderer.view.offsetWidth, renderer.view.offsetHeight

gameDom.addEventListener 'click', onClick
window.addEventListener 'resize', onResize

socket.on "ping", ->
  console.log "pong"

socket.on "sync", (players, bullets) ->
  console.log players
  gameState.players = players
  gameState.bullets = bullets

socket.on "playerMove", (id, from, to, timestamp) ->
  console.log "move"
  gameAction.playerMove id, from, to, timestamp

socket.on "init", (timeOffset) ->
  gameAction.playerJoin playerId, x: 0, y: 0, Date.now(), yes
  console.log playerId

onResize()

###
-----------------------

socket.on 'sync', (state) ->
  gameAction.syncGameState

socket.on 'update.shoot', (playerId, from, to, timestamp) ->
  gameAction.shoot playerId, from, to, timestamp

socket.on 'update.move', (playerId, from, to, timestamp) ->
  gameAction.move playerId, from, to, timestamp

socket.on 'update.die', (playerId, who) ->
  gameAction.die playerId, who

-----------------------

-----------------------
###
