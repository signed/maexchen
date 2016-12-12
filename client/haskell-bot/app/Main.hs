module Main where

import Control.Monad (unless)
import Network.Socket
import Control.Exception

import SimpleBot

-- try out stuff with a server which can be run with this: nc -u 127.0.0.1 3000

-- code courtesy of http://blog.coldflake.com/posts/Simple-Networking/

ipaddress = Just "127.0.0.1"
port = Just "9000"
teamname = "Haskellians"


main :: IO ()
main = withSocketsDo $ bracket connectMe sClose handler
          where
            connectMe = do
              (serveraddr:_) <- getAddrInfo Nothing ipaddress port
              sock <- socket (addrFamily serveraddr) Datagram defaultProtocol
              connect sock (addrAddress serveraddr)
              send sock $ register teamname
              recv sock 1024 >>= \msg -> putStrLn $ "Received " ++ msg
              return sock
