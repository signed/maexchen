module MessageParser ( parseCommand ) where


import Text.ParserCombinators.Parsec
import qualified Text.ParserCombinators.Parsec.Token as T
import Text.ParserCombinators.Parsec.Language

import Command

parseCommand :: String -> Command
parseCommand = run_parser commandParser


run_parser :: Parser a -> String -> a
run_parser p str = case parse p "" str of
  Left err  -> error $ "parse error at " ++ (show err)
  Right val -> val



commandParser :: Parser Command
commandParser = roundStartingP
            <|> unknownP
            <?> "Parse error"


roundStartingP = do
  try $ symbolP "ROUND STARTING"
  semiP
  token <- tokenP
  return $ RoundStarting token

unknownP = do
  unknownCommand <- lineP
  return $ Unknown unknownCommand


lexer = T.makeTokenParser emptyDef

lineP     = many $ noneOf "\n"
semiP     = T.semi lexer
tokenP    = many $ noneOf ";"
symbolP   = T.symbol lexer
