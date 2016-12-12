module Response where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

data Response =
  Register String
  | Join   String
  | See    String

show :: Response -> BS.ByteString
show (Register playername) = BSC.pack $ "REGISTER;" ++ playername
show (Join token)          = BSC.pack $ "JOIN;" ++ token
show (See token)           = BSC.pack $ "SEE;" ++ token
