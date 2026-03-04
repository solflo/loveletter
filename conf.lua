function love.conf(t)
	t.title = "luavn" -- The title of the window the game is in
	t.version = "11.5"         -- The LÖVE version this game was made for
	t.window.width = 640       
	t.window.height = 400


	--------------------------
    --- AESTHETICS ZONE ------
    --------------------------

    font = "pc-9800.ttf" --- fonts are kinda heavy so you may want to omit this
	--- if you do, set it to nil
	fontSize = 16

	imgSize = {512, 300} --- w, h
	textWidth = imgSize[1] --- textbox width == image width
	imgX = (t.window.width - imgSize[1])/2

    imgCoords = {imgX, 20} --- centers the image
    textCoords = {imgX, imgSize[2] + 40} --- positions the textbox
    
    divider = " | " --- the style of divider between nametag and text

    -- nametagColor = {0.84, 0.63, 0.78}
    --- you probably _can_ set a different color per character but that sounds annoyingggg
	--- i just gave up on this function
	


	--------------------------
    --- ASSETS ---------------
    --------------------------


    --- CHARACTERS -----------

	chars = {
        ["!SOL"] = "the dev",
    }

	--- syntax: ["!shorthand"] = "in-game tag",
	--- you don't need to put one per line but you do need the comma separation. and the quotes.
	--- use whatever convention you prefer, three chars will keep length uniform with other syntax tags,
	--- but a single letter (videotome approach) is faster to type
	
	--- IMAGES ---------------

	imgs = {
        ["background"] = "images/placeholder.png",
		["bg2"] = "images/placeholder2.png",
    }

	--- syntax: ["image name"] = "path",
	--- again, quotes and comma.


	--- AUDIO ----------------

	audio = {
		["placeholder"] = "audio/oiter loop.ogg",
		["thud"] = "audio/339832__insanity54__thud.ogg",
	}

	--- same syntax

end