{sqrt} = Math
{findLastIndex} = require 'lodash'

module.exports = (moves, timestamp) ->
  move = moves[findLastIndex moves, (move) -> timestamp > move.timestamp]
  return x: 0, y: 0 unless move
  {from, to, speed, timestamp: moveTimestamp} = move

  dst = {}

  if timestamp <= moveTimestamp
    dst.x = from.x
    dst.y = from.y
    return dst

  distance = sqrt (from.x - to.x) ** 2 + (from.y - to.y) ** 2
  duration = distance / speed

  if timestamp >= moveTimestamp + duration
    dst.x = to.x
    dst.y = to.y
    return dst

  p = (timestamp - moveTimestamp) / duration
  _p = 1 - p

  dst.x = _p * from.x + p * to.x
  dst.y = _p * from.y + p * to.y

  return dst

