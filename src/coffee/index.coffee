GameClient = require "./game-client"
socket = io()

socket.on "connect", ->
  gameClient = new GameClient
    socket: socket
    dom: gameDom

socket.on "reconnect_attempt", (require "lodash").once ->
  console.log "error"
  dummySocket = new (require "events")
  gameClient = new GameClient
    socket: dummySocket
    dom: gameDom

  dummySocket.emit "playerJoin", 1, {x: 0, y: 0}, +new Date
  dummySocket.emit "init", 1
