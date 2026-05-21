function love.conf(t)
	t.modules.physics = false

	t.title = "love letter engine" -- The title of the window the game is in
	title = t.title --- game name for the menu (can be different, don't forget quotes)

	menuText = [[
[enter] / [down] / [left-click] advance
[up] / [scrollwheel up] return
[a] auto
[1 / 2 / 3] auto speed
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
	divider = " | " --- the style of divider between nametag and text. TIP: using \n will create a new line. so divider = " | \n" can be used to put the nametag above the line
	
	defaultSpeed = 7 --- time to auto skip text. the speed adjusts based on line length, so this is seconds per 100 characters
	slowSpeed = 9 --- idem, but for the slow setting
	fastSpeed = 5 --- ibidem, for the fast setting

	--- VISUALS --------------

	bgColor = {0, 0, 0, 1} --- rgba, with values between 0-1. defaults to black
	narrationColor = {1, 1, 1, 1} --- idem. defaults to white. text without dialogue tags
	dialogueColor = {0.6, 0.67, 0.72, 1} --- ibidem. defaults to light blue. an accent color for dialogue lines. they're all the same unless you mess with the engine
	fadedColor = {1, 1, 1, 0.7} --- ibidem. defaults to gray. previously seen text, when viewing history


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