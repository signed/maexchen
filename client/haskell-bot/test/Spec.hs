import qualified MessageParserSpec as MPS
import qualified SimpleBotSpec     as SBS

import Test.Tasty
import Test.Tasty.Hspec


main :: IO ()
main = do
  tests <- fmap concat $ sequence $ map testSpecs [MPS.spec, SBS.spec]
       -- map :: [IO [TestTree]] / sequence :: IO [[TestTree]] / fmap :: IO [TestTree]
  defaultMain $ testGroup "Tests" tests
