{Container} = require 'pixi.js'
PlayersComponent = require "./players"

module.exports = class Splatwoon
  constructor: ->
    @pixiObject = new Container
    @playersComponent = new PlayersComponent

    @pixiObject.addChild @playersComponent.pixiObject

  update: (time, gameState) ->
    @playersComponent.update time, gameState
