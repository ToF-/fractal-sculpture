{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
-- import Diagrams.Backend.SVG.CmdLine
import Diagrams.Backend.Rasterific.CmdLine
import Data.Colour.Palette.BrewerSet

colors  = reverse (brewerSet  Purples  9)

blackSquare :: Double -> Diagram B 
blackSquare size = square size # fc black # lw none

clearSquare :: Int -> Double -> Diagram B
clearSquare colorIndex size = square size 
                        # lw none
                        # fc (colors !! colorIndex) 
                        # opacity ((fromIntegral colorIndex) / 10) 

carve :: Int -> Diagram B -> Diagram B
carve colorIndex background = foldl carveSquare background vectors
    where
        carveSquare diagram vector = (clearSquareAt vector) `atop` diagram
        clearSquareAt vector = translate (r2 vector) (clearSquare colorIndex 0.25)
        vectors = [(-0.125 , 0.375 ), ( 0.125, 0.375 )
                  ,(-0.375 , 0.125 )
                  ,(-0.125 ,-0.375 ), ( 0.125,-0.375 )]

reproduce :: Diagram B -> Diagram B
reproduce diagram = translate (r2 (-0.250,0.250)) 
                        (vcat (replicate 2 
                            (hcat (replicate 2 
                                (scale 0.500 diagram))))) 

sculpt :: Int -> Diagram B
sculpt 1 = carve       0  (blackSquare 1)
sculpt n = carve (pred n) (reproduce (sculpt (pred n)))

main = defaultMain $ sculpt 8
