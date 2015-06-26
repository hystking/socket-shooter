module.exports = class GameServerClient
  constructor: ({@id, @socket, @gameAction}) ->
    @socket.on "playerMove", @_onPlayerMove
    @socket.on "disconnect", @_onDisconnect
    @gameAction.playerJoin @id, {x: 0, y: 0}, +new Date, yes
    @gameAction.sync @socket
    @socket.emit "init", @id

  _onPlayerMove: (id, from, to, timestamp) =>
    @gameAction.playerMove id, from, to, timestamp, yes
  
  _onDisconnect: (id) =>
    console.log "disconnect", @id
    @gameAction.playerLeave @id, yes
    @socket.disconnect true
    @socket = null
    @gameAction = null
    @id = null
