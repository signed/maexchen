SimpleBot = require './simple_bot'
commander = require 'commander'

commander
	.version '1.0.0'
	.option '-H, --host <host name>', 'name or IP of the server'
	.option '-p, --port <port number>', 'port the server is listening at'
	.option '-n, --name <client name>', 'client\'s used to register'
	.option '-b, --localAddress <address>', 'local address to bind the client\'s socket'
	.option '-P, --localPort <port number>', 'local port to bind the client\'s socket'
	.parse process.argv

client = new SimpleBot
	serverAddress: commander.host
	serverPort: commander.port
	clientAddress: commander.localAddress
	clientPort: commander.localPort
	name: commander.name
