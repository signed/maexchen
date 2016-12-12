module MessageParserSpec where

import Test.Tasty
--import Test.Tasty.SmallCheck as SC
--import Test.Tasty.QuickCheck as QC
--import Test.Tasty.HUnit
import Test.Tasty.Hspec

import Command
import MessageParser


main :: IO ()
main = do
  tests <- testSpec "Tests" spec
  defaultMain tests


spec :: Spec
spec =
  describe "parser" $ do
    it "parses ROUND STARTING" $ do
      parseCommand "ROUND STARTING;some-token-id" `shouldBe` (RoundStarting "some-token-id")

    it "parses an unknown command as UNKNOWN" $ do
      parseCommand "ROUND CANCELED;some-token-id" `shouldBe` (Unknown "ROUND CANCELED;some-token-id")
