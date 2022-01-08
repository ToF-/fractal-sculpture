{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

sq :: Double -> Diagram B 
sq s = square s # fc black # showOrigin # opacity 0.2

cl :: Double -> Diagram B
cl s = square s # fc white # showOrigin

carve :: Diagram B -> Diagram B
carve bg = foldl (\d v -> (tr v) `atop` d) bg vs
    where
        tr v = translate (r2 v) (cl 1)
        vs = map sc [(1,0),(2,0),(0,-1),(1,-3),(2,-3)]
        sc (i,j) = (-1.5*f + i*f, 1.5*f +j*f)
        f = 1

carve' :: Diagram B -> Diagram B
carve' bg = foldl (\d v -> (tr v) `atop` d) bg vs
    where
        tr v = translate (r2 v) (cl 1)
        vs = map sc [(1,0),(2,0),(0,-1),(1,-3),(2,-3)]
        sc (i,j) = (-0.5*f + i*f, 0.5*f +j*f)
        f = 1

carve'' :: Diagram B -> Diagram B
carve'' bg = foldl (\d v -> (tr v) `atop` d) bg vs
    where
        tr v = translate (r2 v) (cl 1)
        vs = map sc [(1,0),(2,0),(0,-1),(1,-3),(2,-3)]
        sc (i,j) = (0*f + i*f, 0*f +j*f)
        f = 1

carve''' :: Diagram B -> Diagram B
carve''' bg = foldl (\d v -> (tr v) `atop` d) bg vs
    where
        tr v = translate (r2 v) (cl 1)
        vs = map sc [(1,0),(2,0),(0,-1),(1,-3),(2,-3)]
        sc (i,j) = (0.25*f + i*f, -0.25*f +j*f)
        f = 1
reproduce :: Diagram B -> Diagram B
reproduce d = vcat (replicate 2 (hcat (replicate 2 (scale (0.5) d))))


main = mainWith $ carve''' $ reproduce $ carve'' $ reproduce $ carve' $ reproduce $ carve $ sq 4
