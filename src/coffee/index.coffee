GameClient = require "./game-client"
socket = require "./utils/socket"

gameClient = new GameClient
  socket: socket
  dom: gameDom
