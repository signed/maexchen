datagram = require 'dgram'
log4js = require 'log4js'
applyDefaults = require './apply_defaults'

log = log4js.getLogger 'mia_client_base'

module.exports = class MiaClientBase
	clientCommands = ['REGISTER', 'REGISTER_SPECTATOR', 'JOIN', 'ROLL', 'SEE', 'ANNOUNCE']
	
	commandToFunctionName = (command) -> command.toLowerCase().replace /_([a-z])/g, (match, char) -> return char.toUpperCase()
	
	constructor: (options = {}) ->
		applyDefaults options,
			serverAddress: '127.0.0.1'
			serverPort: '9000'
			clientAddress: ''
			clientPort: '9001'
		{@clientAddress, @clientPort, @serverAddress, @serverPort} = options

		@createSendCommand command for command in clientCommands
		
		@socket = datagram.createSocket 'udp4'
		
		@socket.on 'listening', @onListening
		@socket.on 'message', @handleSocketMessage
		
		@socket.bind @clientPort, @clientAddress
		return
		
	createSendCommand: (command) => @[commandToFunctionName command] = (args...) => @send command, args
		
	onListening: =>
		
	handleSocketMessage: (messageBuffer, remoteInfo) =>
		message = messageBuffer.toString 'utf8'
		log.debug 'received', message
		messageParts = message.split ';'
		@[messageParts[0]]? messageParts[1..]...
		return
		
	send: (command, args...) =>
		args.unshift(command.toString().toUpperCase())
		message = args.join ';'
		log.debug 'sending', message
		messageBuffer = new Buffer message
		@socket.send messageBuffer, 0, messageBuffer.length, @serverPort, @serverAddress, (error, response) ->
			return
		return
		
	done: =>	@socket.close()
		