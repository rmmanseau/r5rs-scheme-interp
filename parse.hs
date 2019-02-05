import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

escaped :: Parser Char
escaped = do
            char '\\'
            esc <- oneOf "\"\\rnt"
            return $ case esc of
                        'r' -> '\r'
                        'n' -> '\n'
                        't' -> '\t'
                        _   -> esc

parseString :: Parser LispVal
parseString = do
                char '"'
                x <- many (escaped <|> noneOf "\"")
                char '"'
                return $ String x

parseAtom :: Parser LispVal
parseAtom = do
                first <- letter <|> symbol
                rest  <- many (letter <|> digit <|> symbol)
                let atom = first:rest
                return $ case atom of
                            "#t" -> Bool True
                            "#f" -> Bool False
                            _    -> Atom atom

parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

-- parseNumber = many1 digit >>= (\ num -> return $ (Number . read) num)

-- parseNumber = do
--                 num <- many1 digit
--                 return $ (Number . read) num


parseExpr :: Parser LispVal
parseExpr = parseAtom <|> parseString <|> parseNumber

readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of
    Left err -> "No match: " ++ show err
    Right val -> case val of
                    String val -> val
                    Number val -> show val
                    _ -> "Found val"

main :: IO ()
main = do
    (expr:_) <- getArgs
    putStrLn (readExpr expr)

