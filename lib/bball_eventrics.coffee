eventric = require 'eventric'
Aggregate = require 'eventric/src/aggregate'
DomainEvent = require 'eventric/src/domain_event'

class BBallGame
  create: (done) ->
    console.log 'BBallGame.create()'
    @$emitDomainEvent 'GameCreated'
    done()

  addPlayer: (params, done) ->
    console.log 'BBallGame.addPlayer()'
    @$emitDomainEvent 'PlayerAdded', params
    done()

  handleGameCreated: (domainEvent) ->
    console.log 'BBallGame.handleGameCreated()'
#    console.dir domainEvent
    @state = {}

  handlePlayerAdded: (domainEvent) ->
    console.log 'BBallGame.handlePlayerAdded()'
#    console.dir domainEvent
    {payload: {team, id}} = domainEvent
    @state[team] ?= {}
    @state[team][id] = 'Player ' + id

    console.dir this

gameContext = eventric.context 'bball game'

#gameContext
#  .defineDomainEvents require './bball_game_events'
#  .addAggregates {BBallGame}
#  .addCommandHandlers require './bball_game_commands'
#  .initialize ->
#    gameContext.command('CreateGame')
#    .then (gameId) -> gameContext.command('AddPlayer', gameId: gameId, team: 'A')
#    .then (gameId) -> gameContext.command('AddPlayer', gameId: gameId, team: 'B')
#    .then (gameId) -> gameContext.emitDomainEvent('PlayerAdded', team: 'A', id: 'PSEUDO')
#    .then -> console.log 'initialized'



aggregate = new Aggregate {}, 'BBallGame', BBallGame
domainEvent1 = new DomainEvent
  name: 'GameCreated'
domainEvent2 = new DomainEvent
  name: 'PlayerAdded'
  payload: { team: 'B', id: 'B1' }
domainEvent3 = new DomainEvent
  name: 'PlayerAdded'
  payload: { team: 'A', id: 'A2' }

console.dir aggregate.root
aggregate.applyDomainEvents [domainEvent1, domainEvent2, domainEvent3]
console.dir aggregate.root
