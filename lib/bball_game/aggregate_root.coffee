uuid = require 'node-uuid'
GameState = require './aggregate_state'

addEventHandlerDelegates = (gameState, target) ->
  for methodName, method of gameState
    addEventHandlerDelegate gameState, target, methodName, method

addEventHandlerDelegate = (gameState, target, methodName, method) ->
  return unless methodName.indexOf('handle') is 0
  target[methodName] = (domainEvent) ->
    method.call gameState, domainEvent.payload

class BBallGame

  constructor: ->
    gameState = new GameState
    addEventHandlerDelegates gameState, this

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

module.exports = BBallGame
