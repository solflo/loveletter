--------------------------
--- PREP -----------------
--------------------------

function love.load()

    --- dealing with images ---

    currentImg = nil

    for i, path in pairs(imgs) do
        --- this takes the image table and formats it properly into a drawable
        formatedPath = string.format(path) --- converts path into string
        imgs[i] = love.graphics.newImage(formatedPath) --- updates the table
    end

    --- dealing with audio ---

    currentMus = nil

    for i, path in pairs(audio) do
        formatedPath = string.format(path) --- converts path into string
        audio[i] = love.audio.newSource(formatedPath, "stream")
        --- "A good rule of thumb is to use stream for music files and static for all short sound effects. Basically, you want to avoid loading large files at once."
    end

    --- ^^ these could be a single reused function but thog don't caare. it'd come down to the same number of lines


    --- dealing with the script ---

    script = {} --- preparing the script table
    currentLine = 1 --- lua is a freak one-indexed language
    maxLines = 0
    
    for line in love.filesystem.lines("script.txt") do
        table.insert(script, line) --- this puts the script into the table, line by line
        maxLines = maxLines + 1 --- counting lines so we know when to end
        --- !EOF could work too if you wanted to have notes within the script without deleting them, but whatever
    end

    parseTags()


    --------------------------
    --- AESTHETICS ZONE ------
    --------------------------

    --- i think this could all go in conf.lua too

    love.graphics.setNewFont(16) --- font size <- well this can't go on conf.lua. i checked.
    --- need to set a font family too

    imgCoords = {64, 20} --- self explanatory i should hope
    textCoords = {64,340}
    textWidth = 512

    divider = " | " --- the style of divider between nametag and text


end


function parseTags() --- checks current line for syntax

    tag = string.match(script[currentLine], "!%w+")
    --- matches bang 1+ alphanumeric char ("!example")
        --- https://www.luadocs.com/docs/functions/string/match#pattern-table
    --- this is diff syntax from videotome, which is "W! - ". easy to change

    if tag == "!MUS" then
        --- parse audio
        print("playing music")

        checkForStop = string.match(script[currentLine], "!MUS stop")

        if checkForStop == nil then
            isStop = false
        elseif checkForStop == "!MUS stop" then
            isStop = true
        end

        if isStop == true then
            love.audio.stop(currentMus)
            currentMus = nil
        else
            newMusic = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
            currentMus = music[newMusic]
            currentMus:setLooping(true)
            currentMus:play()
        end
            
        currentLine = currentLine + 1
        parseTags()
    end

    if tag == "!IMG" then
        --- parse image
        newImage = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
        currentImg = imgs[newImage]
        currentLine = currentLine + 1
        parseTags()
        --- limitation: you can't go back in history past the image
        --- because you'll always get +1 added to currentLine when you get here
    end

    if chars[tag] ~= nil then
        --- if tag exists in the chars table. lua uses ~= instead of !=
        script[currentLine] = string.gsub(script[currentLine], tag, chars[tag] .. divider) --- source string, pattern to match, replacement
    end
end


--------------------------
--- BTS ------------------
--------------------------

function love.update(dt)
    function love.keypressed( key )
        if key == "return" or key == "down" then
            if currentLine < maxLines then
                currentLine = currentLine + 1 --- advances script
            end

            if currentLine == maxLines then
                --- end the game
                love.event.quit() --- in a less jarring way though
            end

        end

        if key == "up" and currentLine > 1 then
            currentLine = currentLine - 1 --- aww yeahh rudimentary history babey
            --- possibility: set a different / fainter color for seen text
            --- and store the "present" line to know when to change color back to normal
        end

        if key == "escape" then
            love.event.quit() --- leave.
        end
    parseTags() --- so it only parses when the game updates instead of every frame
    end
end


--------------------------
--- DISPLAY --------------
--------------------------


function love.draw()
    if currentImg ~= nil then
        love.graphics.draw(currentImg, imgCoords[1], imgCoords[2]) --- image, x, y
        --- i could even do bg + sprites. wowza!
        --- also this should probably be dealt with in the history logic. which sounds like a headache...
    end
    love.graphics.printf(script[currentLine], textCoords[1], textCoords[2], textWidth) --- string, x, y, width
end