
# Configuring the Client

In `app/Main.hs` you need to set the IP address, the port and the team name at the top of the file.

You can either directly use or modify the existing client which is found in `src/HaskellSimpleBot.hs`, or you can add a new bot in its own file.
In order to do the latter, you need to perform the following steps:

* Add the new file to `src`
* Add the new file to the `library` section of `haskell-bot.cabal`
* Replace the import of `HaskellSimpleBot` with an import to your new bot in `app/Main.hs`

# Building the Client

You need [stack]() in your path. Then you can build the Haskell bot with

 `stack build`

# Running the Client

You can run the Haskell bot with

`stack exec bot`


# Running the Tests

You can run the tests with

`stack test`
