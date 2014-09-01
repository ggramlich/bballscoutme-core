{generateUid} = require 'eventric'

class GameCreated

class PlayerAdded
  constructor: ({@team, @id}) ->
    @id ?= generateUid()
    console.log 'PlayerAdded event constructor'
    console.dir this

module.exports = {
  GameCreated
  PlayerAdded
}
