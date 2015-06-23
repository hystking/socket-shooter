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
gameComponent = new GameComponent
renderer = new Renderer 100, 100, transparent: true

gameDom.appendChild renderer.view

setInterval ->
  time = Date.now()
  gameComponent.update time, gameState
  renderer.render gameComponent.pixiObject
, 1000

gameAction.playerJoin 0, x: 0, y: 0, Date.now()
gameAction.playerMove 0, null, {x: 100, y: 100}, Date.now()

gameDom.addEventListener 'click', (e) ->
  gameAction.playerMove 0, null, {x: e.clientX, y: e.clientY}, Date.now()

onResize = ->
  renderer.resize renderer.view.offsetWidth, renderer.view.offsetHeight

window.addEventListener 'resize', onResize

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
