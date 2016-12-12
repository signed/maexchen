module SimpleBot (
    handler
  , register

  , replyFor -- exposure for testing
  ) where

import Prelude hiding (show)
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
    print $ parseCommand msg
    let response = replyFor $ parseCommand msg
    BSC.putStrLn response
    res <- if (BS.null response) then return 0 else send sock response
    handler sock

register :: String -> BS.ByteString
register playername = show $ Register playername

replyFor :: Command -> BS.ByteString
replyFor (RoundStarting token) = show $ Join token
replyFor (YourTurn token)      = show $ See token
replyFor (Unknown _)           = BS.empty
