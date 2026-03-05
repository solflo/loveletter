function love.conf(t)
	t.modules.physics = false

	t.title = "love letter engine" -- The title of the window the game is in
	title = t.title --- game name for the menu (can be different, don't forget quotes)

	menuText = [[
[enter] / [down] / [left-click] advance
[up] / [scrollwheel up] return
[esc] exit
[f] fullscreen
[m] mute ]]
	--- text for main menu / title screen. it's shown literally so tab indents are a no-no :(

	endText = [[
<EOF>


[esc] exit]]
	--- text for the end screen.

	t.window.icon = "icon.png"
		--- if using makelove you also need to specify the icon on the .toml file over there

	t.window.width = 640       
	t.window.height = 400


	--------------------------
    --- AESTHETICS ZONE ------
    --------------------------

	--- TEXT -----------------

    font = "pc-9800.ttf" --- set to nil (no quotes) if you don't include a font file
	fontSize = 16
	divider = " | " --- the style of divider between nametag and text
	    
    -- nametagColor = {0.84, 0.63, 0.78}
    --- you probably _can_ set a different color per character but that sounds annoyingggg
	--- i just gave up on this function

	--- VISUALS --------------

	imgSize = {512, 300} --- w, h
	textWidth = imgSize[1] --- textbox width == image width

	imgX = (t.window.width - imgSize[1])/2 --- default bg position (horizontal) (centered)
	imgY = 20 --- idem (vertical)

	defaultSprX = 264 --- default sprite position (horizontal)
	defaultSprY = 180 --- idem (vertical)
	animationSpeed = 4 --- lower values = faster movement, with 1 being instant

    textCoords = {imgX, imgSize[2] + imgY * 2} --- positions the textbox


	--------------------------
    --- ASSETS ---------------
    --------------------------


    --- CHARACTERS -----------

	chars = {
        ["!SOL"] = "the dev",
    }

	--- syntax: ["!shorthand"] = "in-game tag",
	--- you don't need to put one per line but you do need the comma separation. and the quotes.
	--- use whatever convention you prefer, three chars will keep length uniform with most other syntax tags,
	--- but a single letter (videotome approach) is faster to type
	
	--- IMAGES ---------------

	imgs = {
        ["background"] = "images/placeholder-bg.png",
		["sprite"] = "images/placeholder-sprite.png",
		["puppy"] = "images/placeholder-puppy.png",
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