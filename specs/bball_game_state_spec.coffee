expect = require 'must'
GameState = require '../lib/bball_game_state'

UUID1 = 'id1'

describe 'bball game state', ->
  beforeEach ->
    @gameState = new GameState

  it 'has no players initially', ->
    expect(@gameState.team.A.players).to.be.empty()
    expect(@gameState.team.A.players[UUID1]?).to.be.false()

  it 'accepts player added with id', ->
    @gameState.accept [type: 'PlayerAdded', team: 'A', id: UUID1]

    expect(@gameState.team.A.players).not.to.be.empty()
    expect(@gameState.team.A.players[UUID1]?).to.be.true()


