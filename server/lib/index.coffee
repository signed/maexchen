miaGame = require './miaGame'
miaServer = require './miaServer'

console.log "arguments: [initialDelay=0ms] [port=9000] [startRoundsEarly=false] [answerTimeout=250ms]"

initialDelay = parseInt process.argv[2]
initialDelay = 0 if isNaN initialDelay

port = parseInt process.argv[3]
port = 9000 if isNaN port

startRoundsEarly = process.argv[4] == 'true'

answerTimeout = parseInt process.argv[5]
answerTimeout = 250 if isNaN answerTimeout

game = miaGame.createGame()
game.setBroadcastTimeout answerTimeout
game.doNotStartRoundsEarly() unless startRoundsEarly

server = miaServer.start game, port
server.enableLogging()

console.log "Mia server started on port #{port} with initial delay #{initialDelay}"

setTimeout (-> game.start()), initialDelay

