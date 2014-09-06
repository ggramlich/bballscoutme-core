The BBall Game provides several methods that are invoked by commands and emit events.
Which events are emitted depends on the current state of the BBall Game. Some method calls
might even be illegal für the current state of the game.


    expect = require 'must'
    mock = require 'mock'

This is the uuid that is returned by the fake uuid generator `v4()` method call.

    UUID = 'uuid'

### <a name="FakeGameState"></a> ###
The Fake `GameState` provides a `handleSomeEvent` method that records its call in the `calledMethods` array.

    calledMethods = null
    class GameState
      handleSomeEvent: (event) ->
        calledMethods.push handleSomeEvent: event

We set up the `BBallGame` constructor with the fake uuid generator and fake `GameState`.

    {BBallGame} = mock '../../lib/bball_game/aggregate_root', {
      'node-uuid': v4: -> UUID
      '../../lib/bball_game/aggregate_state': {GameState}
    }, require

The `prepareForTest` function injects a fake `$emitDomainEvent` method into the the given object and returns an object
with a method `expectedEvents`.

    prepareForTest = require '../helper/prepare_for_test'

We describe the behavior of the methods which are called by the command handlers.

    describe 'BBall game method', ->
      beforeEach ->
        @game = new BBallGame
        @testGame = prepareForTest @game

The `create` method leads to a `GameCreated` event.

      describe 'create', ->
        it 'emits GameCreated', ->
          @game.create =>
            @testGame.expectedEvents GameCreated: undefined

The `addPlayer` method leads to a `PlayerAdded` event and adds the `gamePlayerId` attribute.
The `team` attribute must be either `'A'` or `'B'`.

      describe 'addPlayer', ->
        it 'emits PlayerAdded with uuid', ->
          @game.addPlayer team: 'A', (err) =>
            expect(err).to.be.undefined()
            @testGame.expectedEvents PlayerAdded: team: 'A', gamePlayerId: UUID

        it 'emits PlayerAdded with uuid', ->
          @game.addPlayer team: 'B', (err) =>
            expect(err).to.be.undefined()
            @testGame.expectedEvents PlayerAdded: team: 'B', gamePlayerId: UUID

        it 'rejects when a different team than A or B is given', ->
          @game.addPlayer team: 'C', (err) =>
            err.must.exist()
            err.message.must.be 'No valid team given'
            @testGame.expectedEvents()

        it 'rejects when no team is given', ->
          @game.addPlayer {}, (err) =>
            err.must.exist()
            err.message.must.be 'No valid team given'
            @testGame.expectedEvents()

All `handle...` methods from the [`GameState`](#FakeGameState) are available on the `BBallGame` aggregate root
and delegate to the `GameState` using the payload attribute from the original parameter as the parameter.

      describe 'handleSomeEvent', ->
        beforeEach ->
          calledMethods = []

        it 'delegates to the game state', ->
          @game.handleSomeEvent payload: 'x'
          calledMethods.must.eql [handleSomeEvent: 'x']
