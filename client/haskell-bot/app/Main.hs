module Main where

import Control.Exception (bracket)
import Network.Socket hiding (send, recvFrom)
import Network.Socket.ByteString (send, recvFrom)
import Data.ByteString.Char8 (unpack)

import SimpleBot

-- try out stuff with a server which can be run with this: nc -u 127.0.0.1 3000

-- code courtesy of http://blog.coldflake.com/posts/Simple-Networking/

ipaddress = Just "127.0.0.1"
port = Just "9000"
teamname = "Haskellians"


main :: IO ()
main = withSocketsDo $ bracket connectMe close handler
          where
            connectMe = do
              (serveraddr:_) <- getAddrInfo Nothing ipaddress port
              sock <- socket (addrFamily serveraddr) Datagram defaultProtocol
              connect sock (addrAddress serveraddr)
              send sock $ register teamname
              recvFrom sock 1024 >>= \(msg,_) -> putStrLn $ "Received " ++ (unpack msg)
              return sock
