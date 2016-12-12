module SimpleBot (
    handler
  , register
  ) where

import Network.Socket

import Data.List (isPrefixOf)
import Data.ByteString.Char8 (split, pack, unpack)
import Data.Char (digitToInt)


handler :: Socket -> IO ()
handler sock = do
    (msg,n,d) <- recvFrom sock 1024
    -- putStrLn $ "< " ++ msg
    let response = replyFor msg
    putStrLn response
    res <- if (null response) then return 0 else send sock response
    handler sock

register :: String -> String
register teamname = "REGISTER;" ++ teamname

replyFor :: String -> String
replyFor msg
  | isPrefixOf "ROUND STARTING" msg = messageWithToken "JOIN;" msg
  | isPrefixOf "YOUR TURN" msg = messageWithToken "SEE;" msg
  | otherwise = ""


messageWithToken :: String -> String -> String
messageWithToken newMessage oldMessage = let token = head $ tail $ split ';' (pack oldMessage)
                                                     in newMessage ++ (unpack token)
