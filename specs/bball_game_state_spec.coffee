expect = require 'must'
GameState = require '../lib/bball_game/aggregate_state'
{GamePlayer} = require '../lib/bball_game/entities'

UUID1 = 'id1'

describe 'bball game state', ->
  beforeEach ->
    @gameState = new GameState

  it 'has no players initially', ->
    expect(@gameState.team.A.players).to.be.empty()
    expect(@gameState.team.A.players[UUID1]?).to.be.false()

  it 'allows to add a player', ->
    @gameState.handlePlayerAdded team: 'A', gamePlayerId: UUID1

    expect(@gameState.team.A.players).not.to.be.empty()
    expect(@gameState.team.A.players[UUID1]?).to.be.true()

  it 'allows to set the player details', ->
    @gameState.team.A.addPlayer new GamePlayer UUID1
    @gameState.handlePlayerDetailsUpdated team: 'A', gamePlayerId: UUID1, name: 'Name', number: '1'

    @gameState.team.A.players[UUID1].name.must.be 'Name'
    @gameState.team.A.players[UUID1].number.must.be '1'
