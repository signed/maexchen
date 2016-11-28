class Score
	constructor: ->
		@scores = {}

	of: (player) ->
		result = @scores[player.name]
		return result if result?
		return 0
	
	increaseFor: (player) ->
		@scores[player.name] = @of(player) + 1
	
	decreaseFor: (player) ->
		@scores[player.name] = @of(player) - 1

	resetFor: (player) ->
		@scores[player.name] = 0

	all: ->
		result = {}
		for name, score of @scores
			result[name] = score
		result

exports.create = -> new Score

