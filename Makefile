fractal-svg: app/Main.hs
	stack install
	fractal-sculpture-exe -p -w 600 -o fractal.svg
	open fractal.svg
fractal-png: app/Main.hs
	stack install
	fractal-sculpture-exe -p -w 600 -o fractal.png
