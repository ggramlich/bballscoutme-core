# BBall Game Aggregate Root

The [`BBallGame`](#BBallGame) is the aggregate root which holds the [`GameState`](aggregate_state.litcoffee#GameState)
and emits domain events.
The `GameState` provides several methods to handle the domain events.
For each of these event handling methods on the `GameState` the aggregate root has delegate method.

    uuid = require 'node-uuid'
    {GameState} = require './aggregate_state'

Helper function to set up the delegate methods.

    addEventHandlerDelegates = (gameState, target) ->
      for methodName, method of gameState
        addEventHandlerDelegate gameState, target, methodName, method

For a method with a name that starts with `handle` add a method with the same name to the target that delegates to
the given method. The method on the gameState is called with the `domainEvent.payload` attribute of the `domainEvent`
argument of the original method call.
The *eventric* framework calls these `handle...` methods on the aggregate root.

    addEventHandlerDelegate = (gameState, target, methodName, method) ->
      return unless methodName.indexOf('handle') is 0
      target[methodName] = (domainEvent) ->
        method.call gameState, domainEvent.payload

## <a name="BBallGame"></a> BBallGame

The `BBallGame` class that represents the aggregate root.

    class BBallGame

Set up the GameState and the event handling delegate methods.

      constructor: ->
        gameState = new GameState
        addEventHandlerDelegates gameState, this

This is the default method that is called by the *eventric* framework to create the aggregate root
from the persisted events.

      create: (done) ->
        console.log 'BBallGame.create()'
        @$emitDomainEvent 'GameCreated'
        done()

The `addPlayer` method checks the validity of the `params` and emits as `PlayerAdded` event.

      addPlayer: (params, done) ->
        console.log 'BBallGame.addPlayer()'
        if params.team not in ['A', 'B']
          return done new Error 'No valid team given'

        params.gamePlayerId = uuid.v4()
        @$emitDomainEvent 'PlayerAdded', params
        done()

## Export
Export the constructor method for `BBallGame`.

    module.exports = {BBallGame}
