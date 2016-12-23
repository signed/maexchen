module SimpleBot (
    handler
  , register

  , replyFor -- exposure for testing
  ) where

import Network.Socket hiding (send, recvFrom)
import Network.Socket.ByteString (send, recvFrom)

import Command
import MessageParser
import Response

import Data.List (isPrefixOf)
import qualified Data.ByteString.Char8 as BSC
import Data.Char (digitToInt)
import qualified Data.ByteString as BS

import Command
import MessageParser

handler :: Socket -> IO ()
handler sock = do
    (msg,_) <- recvFrom sock 1024
    -- putStrLn $ "< " ++ (BSC.unpack msg)
    let command = parseCommand msg
    putStrLn $ "--> " ++ (show command)
    let response = replyFor command
    putStrLn $ "<-- " ++ (show response)
    if (response == None) then return 0 else send sock (showR response)
    handler sock

register :: String -> Response
register playername = Register playername

replyFor :: Command -> Response
replyFor (RoundStarting token) = Join token
replyFor (YourTurn token)      = See token
replyFor (Unknown _)           = None
