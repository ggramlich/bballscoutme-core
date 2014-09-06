# Entities within the [`BBallGame`](aggregate_root.litcoffee#BBallGame)

## <a name="Team"></a> Team

The `Team` holds the list of `GamePlayer`s and delegates several method calls to them.

    class Team
      constructor: ->
        @players = {}

      addPlayer: (player) ->
        @players[player.id] = player

      updatePlayerDetails: (id, params) ->
        @players[id].updateDetails params

## <a name="GamePlayer"></a> GamePlayer

The `GamePlayer` entity holds information about a player within a game.

    class GamePlayer
      constructor: (@id) ->

      updateDetails: (params) ->
        @name = params.name if params.name?
        @number = params.number if params.number?

## Export

    module.exports = {Team, GamePlayer}