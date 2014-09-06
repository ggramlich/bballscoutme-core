This module represents the statistics of a basketball game constructed from the events that lead to the current state.

It is inspired by the event-sourcing examples from the book Implementing Domain Driven Design by Vaughn Vernon,
especially by the code samples of Rinat Abdullin: https://github.com/Lokad/lokad-iddd-sample

    {Team, GamePlayer} = require './entities'

    module.exports = class GameState

The `GameState` constructor can optionally accept a list of events.
It initializes team.A and team.B.

      constructor: ->
        @team =
          A: new Team
          B: new Team

The `handlePlayerAdded` method delegates to the `Team`'s `addPlayer` method.

      handlePlayerAdded: ({team, gamePlayerId}) ->
        @team[team].addPlayer new GamePlayer gamePlayerId

The `handlePlayerDetailsUpdated` method delegates to the `Team`'s `updatePlayerDetails` method.

      handlePlayerDetailsUpdated: (params) ->
        {team, gamePlayerId} = params
        @team[team].updatePlayerDetails gamePlayerId, params
