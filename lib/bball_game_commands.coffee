createGame = (params, done) ->
  console.log 'CreateGame command called'
#  console.dir this
  repo = @$repository 'BBallGame'
  repo.create().then (gameId) ->
#    console.log "Created: #{gameId}"
    repo.save gameId
  .then (gameId) ->
#    console.log "Save done: #{gameId}"
    done null, gameId

addPlayer = (params, done) ->
  {gameId} = params
  console.log 'AddPlayer command called '
#  console.dir params
#  console.dir this
  repo = @$repository 'BBallGame'
  repo.findById(gameId)
  .then (game) ->
#    console.log 'Game found'
#    console.dir game
    game.addPlayer params, ->
      repo.save gameId
  .then (gameId) ->
    done null, gameId

module.exports =
  CreateGame: createGame
  AddPlayer: addPlayer
