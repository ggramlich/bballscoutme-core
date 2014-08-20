module.exports = class BBallGame
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
