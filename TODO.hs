import System.Environment
import System.Directory
import Data.Time
import Data.List
import System.Exit

remLast :: [a] -> [a]
remLast [h] = []
remLast (h:t) = [h]++remLast t

getTuple (a,b,c,d,e) = a++"   "++b++"   "++c++"   "++d++"   "++e++"\n"

todoPack :: String -> String -> String -> String -> (String,String,String,String,String)
todoPack date fileName filePath todoText = (date,"<file>",(getTodoLine todoText),filePath,fileName)

getTodoLine :: String -> String
getTodoLine str
            | ('T' `elem` str)= findTodo str
            | otherwise="TODO"

findTodo :: String -> String
findTodo text
        | ((text!!0)=='T')&&((text!!1)=='O')&&((text!!2)=='D')&&((text!!3)=='O')=text
        | otherwise = (findTodo (tail text))

todoRead :: IO ()
todoRead = do
        fData <- readFile "TODO.log"
        if (fData=="") then putStrLn "Looks like you don't have any TODO's\nadd file with TODO:\n./TODO <filename>\n...or add a note\n./TODO n \"my note\"\nif you want to remove all your TODO's:\n./TODO d"
        else putStrLn (remLast fData)

note :: String -> String -> IO ()
note date text = appendFile "TODO.log" (date++"   <note>   "++text++"\n")

removeTasks :: IO ()
removeTasks = do
            removeFile "TODO.log"
            writeFile "TODO.log" ""

saveTodo :: (String,String,String,String,String) -> IO ()
saveTodo todoData = appendFile "TODO.log" (getTuple todoData)

doesLogExist :: IO ()
doesLogExist = do
            exists <- doesFileExist "TODO.log"
            if exists then checkArgument
            else writeFile "TODO.log" ""
            putStrLn "creating TODO.log..."
            exitSuccess

checkArgument :: IO ()
checkArgument = do
            argv <- getArgs
            if argv==[] then todoRead
            else (checkSecond argv)
            exitSuccess

checkSecond :: [String] -> IO ()
checkSecond argv= do
            if (head argv)=="d" then removeTasks
            else (checkThird argv)
            exitSuccess

checkThird :: [String] -> IO ()
checkThird argv= do
            currentTime <- getZonedTime
            if (head argv)=="n" then note (take 19 (show currentTime)) (argv!!1)
            else (checkFourth (head argv) (take 19 (show currentTime)))
            exitSuccess
                            

checkFourth :: String -> String -> IO ()
checkFourth currFile currentTime = do
                            fileContents <- readFile currFile
                            filePath <- getCurrentDirectory
                            saveTodo (todoPack currentTime currFile filePath fileContents)

main :: IO ()
main = doesLogExist