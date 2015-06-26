GameDispatcher = require './dispatchers/game'
GameState = require './stores/game-state'
GameAction = require './actions/game'
GameComponent = require './components/game'
Renderer = require './utils/renderer'

module.exports = class Client
  constructor: ({@socket, @dom} = {}) ->
    @playerId = null
    @gameDispatcher = new GameDispatcher
    @gameState = new GameState
      dispatcher: @gameDispatcher
    @gameAction = new GameAction
      dispatcher: @gameDispatcher
      socket: @socket
      gameState: @gameState
    @gameComponent = new GameComponent
    @renderer = new Renderer 100, 100, transparent: true
    @dom.appendChild @renderer.view

    @dom.addEventListener 'click', @_onClick
    window.addEventListener 'resize', @_onResize

    @socket.on "ping", -> console.log "pong"
    @socket.on "init", @_onSocketInit
    @socket.on "sync", @_onSocketSync
    @socket.on "playerMove", @_onSocketPlayerMove
    @socket.on "playerJoin", @_onSocketPlayerJoin
    @socket.on "playerLeave", @_onSocketPlayerLeave
    
    @_onResize()
    @startUpdate()
  
  startUpdate: ->
    setInterval @_update, 16
  
  _update: =>
    time = Date.now()
    @gameComponent.update time, @gameState
    @renderer.render @gameComponent.pixiObject

  _onSocketSync: (players, bullets) =>
    @gameState.players = players
    @gameState.bullets = bullets

  _onClick: (e) =>
    @gameAction.playerMove @playerId, null, {x: e.clientX, y: e.clientY}, Date.now(), yes

  _onResize: =>
    @renderer.resize @renderer.view.offsetWidth, @renderer.view.offsetHeight

  _onSocketPlayerMove: (id, from, to, timestamp) =>
    @gameAction.playerMove id, from, to, timestamp

  _onSocketPlayerJoin: (id, position, timestamp) =>
    @gameAction.playerJoin id, position, timestamp
  
  _onSocketPlayerLeave: (id) =>
    @gameAction.playerLeave id

  _onSocketInit: (id) =>
    @playerId = id
