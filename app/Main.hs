{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

sq :: Diagram B 
sq = square 1

sq4x4 :: Diagram B
sq4x4 = vcat (replicate 4 line)
    where line = hcat (replicate 4 sq)

main = mainWith sq4x4
