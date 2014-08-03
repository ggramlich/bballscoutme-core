This module represents the statistics of a basketball game constructed from the events that lead to the current state.

It is inspired by the event-sourcing examples from the book Implementing Domain Driven Design by Vaughn Vernon,
especially by the code samples of Rinat Abdullin: https://github.com/Lokad/lokad-iddd-sample

    module.exports = class GameState

The GameState constructor can optionally accept a list of events.
It initializes team.A and team.B.

      constructor: (events = []) ->
        @team =
          A: new Team
          B: new Team

        @accept events

The accept method delegates to the handle method for each event in the given list of events.

      accept: (events) ->
        @handle event for event in events

The handle method calls the EventHandler registered for the event.

      handle: (event) ->
        EventHandlers[event.type].call this, event


The EventHandlers object contains a function registered for each event type.

    EventHandlers =
      PlayerAdded: ({team, id}) ->
        @team[team].add new Player id

    class Team
      constructor: ->
        @players = {}
        
      add: (player) ->
        @players[player.id] = player

    class Player
      constructor: (@id) ->
