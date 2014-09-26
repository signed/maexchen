MiaClientBase = require './mia_client_base'
log4js = require 'log4js'
applyDefaults = require './apply_defaults'

log = log4js.getLogger 'simple_bot'

module.exports = class SimpleBot extends MiaClientBase
	maxNameLength = 20
	
	constructor: (options = {}) ->
		applyDefaults options, name: 'CoffeeScript-SimpleBot'
		@name = options.name[...maxNameLength]
		super options
		return
		
	onListening: =>
		super
		@register @name
		return
		
	'ROUND STARTING': (token) =>
		@join token
		return
		
	'YOUR TURN': (token) =>
		@roll token
		return
		
	'ROLLED': (rolls, token) =>
		@announce rolls, token
		return
	
	'REJECTED': =>
		@done()
		return
