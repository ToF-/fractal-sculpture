{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
-- import Diagrams.Backend.SVG.CmdLine
import Diagrams.Backend.Rasterific.CmdLine
import Data.Colour.Palette.BrewerSet

colors  = reverse (brewerSet  Purples  9)

sq :: Double -> Diagram B 
sq s = square s # fc black # lw none

cl :: Int -> Double -> Diagram B
cl i s = square s # fc (colors !! i) # lw none # opacity ((fromIntegral i) / 10) 

carve :: Int -> Diagram B -> Diagram B
carve i bg = foldl (\d v -> (tr v) `atop` d) bg vs
    where
        tr v = translate (r2 v) (cl i 0.25)
        vs = [(-0.125,0.375),(0.125,0.375)
             ,(-0.375,0.125)
             ,(-0.125,-0.375),(0.125,-0.375)]

reproduce :: Diagram B -> Diagram B
reproduce d = (translate (r2 (-0.250,0.250)) (vcat (replicate 2 (hcat (replicate 2 (scale (0.500) d)))))) 

sculpt :: Int -> Diagram B
sculpt 1 = carve 0 (sq 1)
sculpt n = carve (n-1) (reproduce (sculpt (n-1)))

main = defaultMain $ sculpt 8
