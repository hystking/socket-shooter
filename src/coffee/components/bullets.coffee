{Container} = require 'pixi.js'
{find, indexOf, findIndexOf} = require 'lodash'

BulletComponent = require './bullet'

module.exports = class Bullets
  constructor: ->
    @bulletComponents = []
    @pixiObject = new Container

  update: (time, gameState) ->
    #bullets
    for bulletComponent in @bulletComponents
      return unless bulletComponent?
      bullet = find gameState.bullets, (p) -> p.id is bulletComponent.bulletId
      @_removeBulletComponent bulletComponent unless bullet?

    for bullet in gameState.bullets
      bulletComponent = @_findOrCreateBulletComponent bullet
      bulletComponent.update time, gameState
    
    for bullet in gameState.bullets
      bulletComponent = @_findOrCreateBulletComponent bullet

  _removeBulletComponent: (bulletComponent) =>
    @pixiObject.removeChild bulletComponent.pixiObject
    remove @bulletComponents, (_bulletComponent) -> _bulletComponent is bulletComponent

  _findOrCreateBulletComponent: (bullet) ->
    bulletComponent = find @bulletComponents, (p) -> p.bulletId is bullet.id
    return bulletComponent if bulletComponent?
    bulletComponent = new BulletComponent bullet
    @bulletComponents.push bulletComponent
    @pixiObject.addChild bulletComponent.pixiObject
    return bulletComponent
