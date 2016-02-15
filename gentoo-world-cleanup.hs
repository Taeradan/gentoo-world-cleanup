#!/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}

import qualified Data.List as L
import qualified Data.Text as T
import           Prelude hiding (FilePath)
import           Turtle

--worldPath = "world"
worldPath = "/var/lib/portage/world"

main = do
    echo $ "Opening " <> worldPath
    echo ""

    fileContent <- strict . input . fromString . T.unpack $ worldPath
    let programsList = T.lines fileContent
    echo "* File contents:"
    echo fileContent
    echo ""

    rawResults <- mapM (\ x -> procStrict "qdepends" ["-Q", x] empty ) programsList
    let completeResults = zip programsList rawResults
        (endPrograms, dependsPrograms) = L.partition (\ (_, (_, x)) -> T.null x) completeResults
        newWorldFile = T.unlines . map fst $ endPrograms

    echo "* Raw Results:"
    print rawResults
    echo ""
    echo "* Programs that are not dependencies:"
    print endPrograms
    echo ""
    echo "* Programs that are dependancies of other programs:"
    print dependsPrograms
    echo ""
    echo "* New world file (written to \"world.filtered\")"
    echo newWorldFile
    output "world.filtered" (return newWorldFile)
