{Container} = require 'pixi.js'
{find, findIndexOf} = require 'lodash'

PlayerComponent = require './player'

module.exports = class Splatwoon
  constructor: ->
    @playerComponents = []
    @bulletComponents = []
    @pixiObject = new Container

  update: (time, gameState) ->
    #players

    for playerComponent in @playerComponents
      @_removePlayerComponent playerComponent unless (find gameState.players, id: playerComponent.player.id)?

    for player in gameState.players
      playerComponent = @_findOrCreatePlayerComponent player
      playerComponent.update time, gameState
    
    for bullet in gameState.players
      playerComponent = @_findOrCreatePlayerComponent player

  _removePlayerComponent: (playerComponent) ->
    @pixiObject.removeChild playerComponent
    @playerComponents.splice (indexOf @playerComponents, playerComponent), 1


  _findOrCreatePlayerComponent: (player) ->
    playerComponent = find @playerComponents, (p) -> p.player.id is player.id
    return playerComponent if playerComponent?
    playerComponent = new PlayerComponent player
    @playerComponents.push playerComponent
    @pixiObject.addChild playerComponent.pixiObject
    return playerComponent
