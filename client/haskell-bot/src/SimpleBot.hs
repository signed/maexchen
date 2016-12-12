module SimpleBot (
    handler
  , register
  ) where

import Network.Socket hiding (send, recvFrom)
import Network.Socket.ByteString (send, recvFrom)

import Command
import MessageParser

import Data.List (isPrefixOf)
import qualified Data.ByteString.Char8 as BSC
import Data.Char (digitToInt)
import qualified Data.ByteString as BS


handler :: Socket -> IO ()
handler sock = do
    (msg,_) <- recvFrom sock 1024
    putStrLn $ "< " ++ (BSC.unpack msg)
    print $ parseCommand (BSC.unpack msg)
    let response = replyFor msg
    BSC.putStrLn response
    res <- if (BS.null response) then return 0 else send sock response
    handler sock

register :: String -> BS.ByteString
register teamname = BSC.pack $ "REGISTER;" ++ teamname

replyFor :: BS.ByteString -> BS.ByteString
replyFor msg
  | BS.isPrefixOf (BSC.pack "ROUND STARTING") msg = messageWithToken "JOIN;" msg
  | BS.isPrefixOf (BSC.pack "YOUR TURN") msg = messageWithToken "SEE;" msg
  | otherwise = BS.empty


messageWithToken :: String -> BS.ByteString -> BS.ByteString
messageWithToken newMessage oldMessage = let token = head $ tail $ BSC.split ';' oldMessage
                                                     in BS.append (BSC.pack newMessage) token
