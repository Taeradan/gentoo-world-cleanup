#!/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T
import           Prelude hiding (FilePath)
import           Turtle

worldPath :: Text
worldPath = "/var/lib/portage/world"

main = do
    echo $ "Opening " <> worldPath
    echo ""
    fileContent <- strict . input . fromString . T.unpack $ worldPath
    let programsList = T.lines fileContent
    -- Affichage du contenu complet du fichier
    echo fileContent

