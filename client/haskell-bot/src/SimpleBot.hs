module SimpleBot (
    handler
  , register
  ) where

import Network.Socket hiding (send, recvFrom)
import Network.Socket.ByteString (send, recvFrom)

import Data.List (isPrefixOf)
import Data.ByteString.Char8 (split, pack)
import Data.Char (digitToInt)
import qualified Data.ByteString as BS


handler :: Socket -> IO ()
handler sock = do
    (msg,_) <- recvFrom sock 1024
    -- putStrLn $ "< " ++ msg
    let response = replyFor msg
    print response
    res <- if (BS.null response) then return 0 else send sock response
    handler sock

register :: String -> BS.ByteString
register teamname = pack $ "REGISTER;" ++ teamname

replyFor :: BS.ByteString -> BS.ByteString
replyFor msg
  | BS.isPrefixOf (pack "ROUND STARTING") msg = messageWithToken "JOIN;" msg
  | BS.isPrefixOf (pack "YOUR TURN") msg = messageWithToken "SEE;" msg
  | otherwise = BS.empty


messageWithToken :: String -> BS.ByteString -> BS.ByteString
messageWithToken newMessage oldMessage = let token = head $ tail $ split ';' oldMessage
                                                     in BS.append (pack newMessage) token
