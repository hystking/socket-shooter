{Container} = require 'pixi.js'
{find, indexOf, findIndexOf, remove} = require 'lodash'

PlayerComponent = require './player'

module.exports = class Players
  constructor: ->
    @playerComponents = []
    @pixiObject = new Container

  update: (time, gameState) ->
    #players
    for playerComponent in @playerComponents by -1
      player = find gameState.players, (p) -> p.id is playerComponent.playerId
      @_removePlayerComponent playerComponent unless player?

    for player in gameState.players
      playerComponent = @_findOrCreatePlayerComponent player
      playerComponent.update time, gameState
    
    for bullet in gameState.players
      playerComponent = @_findOrCreatePlayerComponent player

  _removePlayerComponent: (playerComponent) =>
    @pixiObject.removeChild playerComponent.pixiObject
    remove @playerComponents, (_playerComponent) -> _playerComponent is playerComponent

  _findOrCreatePlayerComponent: (player) ->
    playerComponent = find @playerComponents, (p) -> p.playerId is player.id
    return playerComponent if playerComponent?
    playerComponent = new PlayerComponent player
    @playerComponents.push playerComponent
    @pixiObject.addChild playerComponent.pixiObject
    return playerComponent
