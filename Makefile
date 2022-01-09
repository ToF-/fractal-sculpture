fractal-svg: app/Main.hs
	stack install
	fractal-sculpture-exe -p -w 1000 -o fractal.svg
	open fractal.svg
fractal-png: app/Main.hs
	stack install
	fractal-sculpture-exe -w 1000 -o fractal.png
	open fractal.png
