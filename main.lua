------------------------------------------------------
------------------------------------------------------
--- LOVE LETTER ENGINE -------------------------------
------------------- v. 0.2 ---------------------------
------------------------------------------------------

-- well so this here is a tiny engine for kinetic visual novels.
-- inspired by freya campbell's videotome (https://communistsister.itch.io/videotome),
-- written in love2d by solflo (https://solflo.neocities.org/)


function love.load()

    if font == nil then
        love.graphics.setNewFont(fontSize)
    else
        love.graphics.setNewFont(font, fontSize)
    end
    --- font path and size go in conf.lua

    --- dealing with images ---

    currentImg = nil
    currentSprite = nil

    for i, path in pairs(imgs) do
        --- this takes the image table and formats it properly into a drawable
        formatedPath = string.format(path) --- converts path into string
        imgs[i] = love.graphics.newImage(formatedPath) --- updates the table
    end

    --- dealing with audio ---

    volume = 1.0

    currentMus = nil
    currentSfx = nil

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

end


---------------------------
--- FUNCTIONS -------------
---------------------------


function parseTags() --- checks current line for syntax

    if script[currentLine] ~= nil then

        tag = string.match(script[currentLine], "!%w+")
        --- matches bang 1+ alphanumeric char ("!example")
            --- https://www.luadocs.com/docs/functions/string/match#pattern-table
        --- this is diff syntax from videotome, which is "W! - ". easy to change
        -- hasNametag = false

        if tag == "!MUS" or tag == "!SFX" then
            --- parse audio
            
            if tag == "!MUS" then
                checkForStop = string.match(script[currentLine], "stop")

                if checkForStop == nil then
                    isStop = false
                elseif checkForStop == "stop" then
                    isStop = true
                end

                if isStop == true and currentMus ~= nil then
                    love.audio.stop(currentMus)
                    currentMus = nil
                elseif isStop == true and currentMus == nil then
                    return
                else
                    newMusic = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
                    currentMus = audio[newMusic]
                    currentMus:setLooping(true)
                    currentMus:play()
                end
            end

            if tag == "!SFX" then
                sfx = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
                currentSfx = audio[sfx]
                currentSfx:setLooping(false)
                currentSfx:play()
            end

            table.remove(script, currentLine) --- removes line (for history purposes)

            parseTags()
        end

        if tag == "!BG" then
            --- parse image
            newImage = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
            currentImg = imgs[newImage]

            table.remove(script, currentLine) --- removes line (for history purposes)
            --- limitation: last image remains on screen always

            parseTags()
        end

        if tag == "!SPR" then
            --- parse sprite
            checkForHide = string.match(script[currentLine], "hide")

            if checkForHide == nil then
                isHide = false
            elseif checkForHide == "hide" then
                isHide = true
            end

            if isHide == true then
                currentSprite = nil
            elseif isHide == false then
                newSprite = string.gsub(script[currentLine], tag .. " ", "")
                currentSprite = imgs[newSprite]
            end

            table.remove(script, currentLine)

            parseTags()
        end

        if chars[tag] ~= nil then
            --- if tag exists in the chars table. lua uses ~= instead of !=
            -- hasNametag = true --- killed this thought
            script[currentLine] = string.gsub(script[currentLine], tag, chars[tag] .. divider) --- source string, pattern to match, replacement
        end
    end
end

function advanceScript()
    if currentLine < maxLines then
        currentLine = currentLine + 1 --- advances script
        parseTags() --- so it only parses when the game updates instead of every frame
    end

    if currentLine >= maxLines then
        --- end the game
        love.event.quit() --- in a less jarring way though
    end
end

function returnScript()
    if currentLine > 1 then
        currentLine = currentLine - 1
    end
    --- aww yeahh rudimentary history babey
    --- possibility: set a different / fainter color for seen text
    --- and store the "present" line to know when to change color back to normal
end

--------------------------
--- CONTROLS -------------
--------------------------

function love.update(dt)
    if script[currentLine] == nil then
        love.event.quit() --- leave.
    end

    function love.keypressed( key )
        if key == "return" or key == "down" then
            advanceScript()
        end

        if key == "up" then
            returnScript()
        end

        if key == "f" then
            fullscreen = not fullscreen
            love.window.setFullscreen(fullscreen, "exclusive")
        end

        if key == "m" then
            if volume == 1.0 then
                volume = 0.0
            elseif volume == 0.0 then
                volume = 1.0
            end
            love.audio.setVolume(volume)
        end

        if key == "escape" then
            love.event.quit() --- leave.
        end
    end

    function love.mousereleased(x, y, button)
        if button == 1 then
            advanceScript()
        end
   end

   function love.wheelmoved(x, y)
        if y > 0 then
            -- scroll up
            returnScript()
        elseif y < 0 then
            -- scroll down
            advanceScript()
        end
    end

end


--------------------------
--- DISPLAY --------------
--------------------------


function love.draw()
    if currentImg ~= nil then
        love.graphics.draw(currentImg, imgCoords[1], imgCoords[2]) --- image, x, y
    end

    if currentSprite ~= nil then
        love.graphics.draw(currentSprite, spriteCoords[1], spriteCoords[2])
    end

    -- if hasNametag == true then
    --     love.graphics.setColor(nametagColor)
    --     love.graphics.printf(script[currentLine], textCoords[1], textCoords[2], textWidth)
    --     love.graphics.setColor(1,1,1)
    -- else
    --     love.graphics.setColor(1,1,1)
    --     love.graphics.printf(script[currentLine], textCoords[1], textCoords[2], textWidth) --- string, x, y, width
    -- end

    love.graphics.printf(script[currentLine], textCoords[1], textCoords[2], textWidth) --- string, x, y, width
end