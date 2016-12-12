module Response where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

data Response =
  Register String
  | Join   String
  | See    String
  | None
  deriving (Eq, Show)

showR :: Response -> BS.ByteString
showR (Register playername) = BSC.pack $ "REGISTER;" ++ playername
showR (Join token)          = BSC.pack $ "JOIN;" ++ token
showR (See token)           = BSC.pack $ "SEE;" ++ token
showR None                  = BS.empty
