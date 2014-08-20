eventric = require 'eventric'
Aggregate = require 'eventric/src/aggregate'
DomainEvent = require 'eventric/src/domain_event'
BBallGame = require '../lib/bball_game_aggregate'

gameContext = eventric.context 'bball game'

gameContext
  .defineDomainEvents require '../lib/bball_game_events'
  .addAggregates {BBallGame}
  .addCommandHandlers require '../lib/bball_game_commands'

class EventricGivenWhenThen

  given: (givenDomainEvents = []) ->
    aggregate = new Aggregate {}, 'BBallGame', BBallGame
    domainEvents = (new DomainEvent domainEvent for domainEvent in givenDomainEvents)
    aggregate.applyDomainEvents domainEvents
    # TODO: save aggregate, resp. the events in repo
    this

  when: (@command, @params) ->
    gameContext.command(@command, @params)
    this

  then: (expectedDomainEvents, @done) ->
    @expectedStringifiedEvents = (stringifyEvent(expectedEvent) for expectedEvent in expectedDomainEvents)
    gameContext.subscribeToDomainEvent expectedEvent.name, @_handleDomainEvent for expectedEvent in expectedDomainEvents
    this

  _handleDomainEvent: (domainEvent) =>
    actualStringifiedEvent = stringifyEvent domainEvent
    if actualStringifiedEvent not in @expectedStringifiedEvents
      return @done new Error "Event was emitted, but not expected #{actualStringifiedEvent}"

    removeFromArray actualStringifiedEvent,  @expectedStringifiedEvents

    if @expectedStringifiedEvents.length == 0
      @done()

  stringifyEvent = (domainEvent) ->
    # We only want these two attributes for the comparison
    {name, payload} = domainEvent
    JSON.stringify({name, payload})

  removeFromArray = (element, array) ->
    for key, value of array
      if element is value
        array.splice(key, 1)


given = (domainEvents) -> new EventricGivenWhenThen().given domainEvents

describe 'BBall Game', ->
  beforeEach (done) ->
    gameContext.initialize done

  it 'can be created', (done) ->
    given()
    .when('CreateGame')
    .then([
      {name: 'GameCreated', payload: {}}
    ], done)

  it.skip 'can have a player added', (done) ->
    id = 'xxxx'
    given([
      {name: 'GameCreated', payload: {}, id}
    ])
    .when('AddPlayer', {gameId: id, team: 'A'})
    .then([
      {name: 'PlayerAdded', payload: {}}
    ], done)

