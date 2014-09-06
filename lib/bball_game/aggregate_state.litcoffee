# The [`BBallGame`](aggregate_root.litcoffee#BBallGame) aggregate's state which contains the two teams and their players

This module represents the statistics of a basketball game constructed from the events that lead to the current state.

It is inspired by the event-sourcing examples from the book Implementing Domain Driven Design by Vaughn Vernon,
especially by the code samples of Rinat Abdullin: https://github.com/Lokad/lokad-iddd-sample

Import the [entity classes](entities.litcoffee).

    {Team, GamePlayer} = require './entities'

## <a name="GameState></a> `GameState`

    class GameState

The `GameState` constructor initializes team.A and team.B.

      constructor: ->
        @team =
          A: new Team
          B: new Team

The `handlePlayerAdded` method delegates to the [`Team's`](entities.litcoffee#Team) `addPlayer` method.

      handlePlayerAdded: ({team, gamePlayerId}) ->
        @team[team].addPlayer new GamePlayer gamePlayerId

The `handlePlayerDetailsUpdated` method delegates to the `Team's` `updatePlayerDetails` method.

      handlePlayerDetailsUpdated: (params) ->
        {team, gamePlayerId} = params
        @team[team].updatePlayerDetails gamePlayerId, params

## Export

    module.exports = {GameState}
