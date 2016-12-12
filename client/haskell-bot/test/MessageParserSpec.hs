module MessageParserSpec where

import Test.Tasty.Hspec
import Data.ByteString.Char8 (pack)

import Command
import MessageParser


spec :: Spec
spec =
  describe "parser" $ do
    it "parses ROUND STARTING" $ do
      parseCommand (pack "ROUND STARTING;some-token-456") `shouldBe` (RoundStarting "some-token-456")

    it "parses YOUR TURN" $ do
      parseCommand (pack "YOUR TURN;some-token-123") `shouldBe` (YourTurn "some-token-123")

    it "parses an unknown command as UNKNOWN" $ do
      parseCommand (pack "REGISTERED") `shouldBe` (Unknown "REGISTERED")
      parseCommand (pack "REJECTED") `shouldBe` (Unknown "REJECTED")
      parseCommand (pack "ROUND STARTED;503;PlayerA,PlayerB") `shouldBe` (Unknown "ROUND STARTED;503;PlayerA,PlayerB")
      parseCommand (pack "PLAYER ROLLS;PlayerA") `shouldBe` (Unknown "PLAYER ROLLS;PlayerA")
      parseCommand (pack "ROLLED;4,2;some-token") `shouldBe` (Unknown "ROLLED;4,2;some-token")
      parseCommand (pack "ANNOUNCED;PlayerA;5,5") `shouldBe` (Unknown "ANNOUNCED;PlayerA;5,5")
      parseCommand (pack "PLAYER WANTS TO SEE;PlayerA") `shouldBe` (Unknown "PLAYER WANTS TO SEE;PlayerA")
      parseCommand (pack "ACTUAL DICE;5,5") `shouldBe` (Unknown "ACTUAL DICE;5,5")
      parseCommand (pack "PLAYER LOST;PlayerB;SOME_REASON") `shouldBe` (Unknown "PLAYER LOST;PlayerB;SOME_REASON")
      parseCommand (pack "SCORE;PlayerX:62,PlayerY:33") `shouldBe` (Unknown "SCORE;PlayerX:62,PlayerY:33")
      parseCommand (pack "ROUND CANCELED;SOME_REASON") `shouldBe` (Unknown "ROUND CANCELED;SOME_REASON")
