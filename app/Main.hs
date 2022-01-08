{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

sq :: Diagram B 
sq = square 1 # fc black

cl :: Diagram B
cl = square 1 # fc white

cls :: Diagram B
cls = translate (r2 (-1.5,1.5)) $ foldl (\d v -> d `atop` translate (r2 v) cl) mempty [(1.0,0.0),(2,0),(0.0,-1.0),(1.0,-3.0),(2.0,-3.0)]

carve :: Diagram B -> Diagram B
carve d = cls `atop` (d # scale 4)

reproduce :: Diagram B -> Diagram B
reproduce d = vcat (replicate 2 (hcat (replicate 2 d)))

shrink :: Diagram B -> Diagram B
shrink = scale 0.5

main = mainWith $ reproduce $ carve $ sq 
