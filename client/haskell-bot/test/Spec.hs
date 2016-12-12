import qualified MessageParserSpec as MPS
import qualified SimpleBotSpec     as SBS
import qualified ResponseSpec      as RS

import Test.Tasty
import Test.Tasty.Hspec


specs = [MPS.spec, SBS.spec, RS.spec]

main :: IO ()
main = do
  tests <- fmap concat $ sequence $ map testSpecs specs
       -- map :: [IO [TestTree]] / sequence :: IO [[TestTree]] / fmap :: IO [TestTree]
  defaultMain $ testGroup "Tests" tests
