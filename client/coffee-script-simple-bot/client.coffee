SimpleBot = require './simple_bot'
commander = require 'commander'

commander
	.version '1.0.0'
	.option '-H, --host <host name>', 'name or IP of the server, defaults to \'127.0.0.1\''
	.option '-P, --port <port number>', 'port the server is listening at, defaults to \'9000\''
	.option '-n, --name <client name>', 'client\'s name used to register, defaults to \'CoffeeScript-SimpleBot\''
	.option '-b, --localAddress <address>', 'local address to bind the client\'s socket, defaults to \'\''
	.option '-p, --localPort <port number>', 'local port to bind the client\'s socket, defaults to \'9001\''
	.parse process.argv

client = new SimpleBot
	serverAddress: commander.host
	serverPort: commander.port
	clientAddress: commander.localAddress
	clientPort: commander.localPort
	name: commander.name
