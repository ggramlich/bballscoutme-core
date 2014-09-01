uuid = require 'node-uuid'

module.exports = class BBallGame
  create: (done) ->
    console.log 'BBallGame.create()'
    @$emitDomainEvent 'GameCreated'
    done()

  addPlayer: (params, done) ->
    console.log 'BBallGame.addPlayer()'
    if params.team not in ['A', 'B']
      return done new Error 'No valid team given'

    params.gamePlayerId = uuid.v4()
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
    @state[team][id] = 'GamePlayer ' + id

    console.dir this
