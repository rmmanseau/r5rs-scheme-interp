module Main where
import System.Environment

main :: IO () -- () type declaration is optional
main = do
    -- args <- getArgs
    -- mapM_ (\ arg -> do putStrLn ("Hello, " ++ arg ++ "!")) args
    line <- getLine
    putStrLn ("Hello, " ++ line ++ "!")

