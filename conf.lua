function love.conf(t)
	t.title = "luavn" -- The title of the window the game is in
	t.version = "11.5"         -- The LÖVE version this game was made for
	t.window.width = 640       
	t.window.height = 400

	


	--------------------------
    --- ASSETS ---------------
    --------------------------


    --- CHARACTERS -----------

	chars = {
        ["!SOL"] = "the dev",
    }

	--- syntax: ["!shorthand"] = "in-game tag",
	--- you don't need to put one per line but you do need the comma separation. and the quotes.
	--- use whatever convention you prefer, three chars will keep length uniform with other syntax tags
	
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
	}

	--- same syntax

end