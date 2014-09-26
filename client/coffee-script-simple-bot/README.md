# CoffeeScript SimpleBot

A simple bot for mia written in CoffeeScript.

## Setup

```
npm install -g coffee-script
npm install
```

## Usage

```
coffee client.coffee [options]

Options:
	-h, --help                     output usage information
	-V, --version                  output the version number
	-H, --host <host name>         name or IP of the server
	-p, --port <port number>       port the server is listening at
	-n, --name <client name>       client's used to register
	-b, --localAddress <address>   local address to bind the client's socket
	-P, --localPort <port number>  local port to bind the client's socket
```

## API

Extend `MiaClientBase` to write your own bot.

### MiaClientBase#constructor(options = {})

Creates a new `MiaClientBase` instance and sets up the socket.

The following options are used:

* `serverAddress`: The address or name at which the server is listening, defaults to `127.0.0.1`.
* `serverPort`: The port at which the server is listening, defaults to `9000`.
* `clientAddress`: The address or name to which the client's socket should be bound, defaults to empty string, which resolves to all interfaces.
* `clientPort`: The port to which the client's socket should be bound, defaults to `9001`

### Receiving Messages

To listen for certain messages, create a function with the same name as the message id. You may do this in a subclass of `MiaClientBase`.

Currently the following messages are supported by the server:

* `REGISTERED`: The registration with the server was successful.
* `REJECTED`: The registration with the server failed.
* `'ROUND STARTING'(token)`: notification, that a new round is about to start. If you want to participate, send `JOIN` an use the provided token.
* `'ROUND STARTED'(roundNumber, players)`: A new round started. `players` is a comma separated list of all participating players in order of their turns.
* `'ROUND CANCELED'(reason)`: The current round was cancelled. `reason` can be `NO_PLAYERS` if no players joined or `ONLY_ONE_PLAYER` if only one player joined.
* `'YOUR TURN'(token)`: It is your turn. Send the token with your next `ROLL` or `SEE` message.
* `'PLAYER ROLLS'(name)`: The player `name` rolls the dice.
* `ROLLED(dice, token)`: Tells you which dice you rolled. Send the token with your announcement.
* `ANNOUNCED(name, dice)`: The player `name` announced `dice`.
* `'PLAYER LOST'(names, reason)`: `names` is a comma separated list of all players that lost. `reason` can be:
	* `SEE_BEFORE_FIRST_ROLL`: The player wanted to see before the first roll was made.
	* `LIED_ABOUT_MIA`: The player announced a mia, without having one.
	* `ANNOUNCED_LOSING_DICE`: The player announced lesser dice than is predecessor.
	* `DID_NOT_ANNOUNCE`: The player didn't make an announcement in time.
	* `DID_NOT_TAKE_TURN`: The player didn't see or roll in time.
	* `INVALID_TURN`: The player made an invalid turn.
	* `SEE_FAILED`: The player wanted to see and his predecessor did announce the dice he rolled.
	* `CAUGHT_BLUFFING`: The player did announce different dice than he rolled and his successor wanted to see.
	* `MIA`: A mia was uncovered.
* `'PLAYER WANTS TO SEE'(name)`: The player `name` wants to see the dice from his predecessor.
* `ACTUAL DICE(dice)`: The actual rolled dice.
* `SCORE(pointlist)`: `pointlist` is a comma separated list of entries of the type `name:points`.

### MiaClientBase#register(name)

Register with the server using a specified name. Wrapper for sending the message `REGISTER;<name>`.

### MiaClientBase#registerSepctator(name)

Register a spectator with the server using a specified name. Wrapper for sending the message `REGISTER_SPACTATOR;<name>`.

### MiaClientBase#join(token)

Join the next game. Wrapper for sending the message `JOIN;<token>`.

### MiaClientBase#roll(token)

Roll the dices. Wrapper for sending the message `ROLL;<token>`.

### MiaClientBase#see(token)

See your opponents roll if you don't believe in his announcement. Wrapper for sending the message `SEE;<token>`.

### MiaClientBase#announce(dice, token)

Announce the specified dice. Wrapper for sending the message `ANNOUNCE;<dice>;<token>`.
