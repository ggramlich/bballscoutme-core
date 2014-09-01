
    class Team
      constructor: ->
        @players = {}

      addPlayer: (player) ->
        @players[player.id] = player

      updatePlayerDetails: (id, params) ->
        @players[id].updateDetails params

    class GamePlayer
      constructor: (@id) ->

      updateDetails: (params) ->
        @name = params.name if params.name?
        @number = params.number if params.number?

    module.exports = {Team, GamePlayer}