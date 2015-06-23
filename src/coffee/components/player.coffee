{last} = require 'lodash'
{Sprite, Texture} = require 'pixi.js'
calcMove = require '../utils/calc-move'

manTexture = Texture.fromImage 'img/man.png'
module.exports = class PlayerComponent
  constructor: (@player) ->
    @pixiObject = new Sprite manTexture
    @pixiObject.pivot.x = @pixiObject.width / 2
    @pixiObject.pivot.y = @pixiObject.height / 2

  update: (time, gameState) ->
    position = calcMove @player.state.moves, time
    @pixiObject.position.x = position.x
    @pixiObject.position.y = position.y
