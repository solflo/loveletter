------------------------------------------------------
------------------------------------------------------
--- LOVE LETTER ENGINE -------------------------------
------------------- v. 1.2.1 -------------------------
------------------------------------------------------

-- well so this here is a tiny engine for kinetic visual novels.
-- inspired by freya campbell's videotome (https://communistsister.itch.io/videotome),
-- written in love2d by solflo (https://solflo.neocities.org/)


function love.load()

    gamestate = "menu"

    if font == nil then
        love.graphics.setNewFont(fontSize)
    else
        love.graphics.setNewFont(font, fontSize)
    end
    --- font path and size go in conf.lua

    --- dealing with images ---

    for i, path in pairs(imgs) do
        --- this takes the image table and formats it properly into a drawable
        formatedPath = string.format(path) --- converts path into string
        imgs[i] = love.graphics.newImage(formatedPath) --- updates the table
    end

    --- dealing with audio ---

    volume = 1.0

    for i, path in pairs(audio) do
        formatedPath = string.format(path) --- converts path into string
        audio[i] = love.audio.newSource(formatedPath, "stream")
        --- "A good rule of thumb is to use stream for music files and static for all short sound effects. Basically, you want to avoid loading large files at once."
    end

    --- ^^ these could be a single reused function but thog don't caare. it'd come down to the same number of lines

    reset()

end


---------------------------
--- FUNCTIONS -------------
---------------------------

function reset() --- puts the game into a freshly opened state

    --- images ---

    currentImg = nil
    currentSprite = nil
    oldSprite = nil
    newSprite = nil

    sprX = defaultSprX
    sprY = defaultSprY
    newX = nil
    newY = nil

    --- audio ---

    currentMus = nil
    currentSfx = nil


    --- dealing with the script ---

    script = {} --- preparing the script table
    currentLine = 1 --- lua is a freak one-indexed language
    maxLines = 0

    auto = false
    autoSpeed = defaultSpeed
    timer = 0
    
    for line in love.filesystem.lines("script.txt") do
        table.insert(script, line) --- this puts the script into the table, line by line
        maxLines = maxLines + 1 --- counting lines so we know when to end
        --- !EOF could work too if you wanted to have notes within the script without deleting them, but whatever
    end

    parseTags()


end

function parseTags() --- checks current line for syntax

    if script[currentLine] ~= nil then

        tag = string.match(script[currentLine], "!%w+")
        --- matches bang 1+ alphanumeric char ("!example")
            --- https://www.luadocs.com/docs/functions/string/match#pattern-table
        --- this is diff syntax from videotome, which is "W! - ". easy to change
        -- hasNametag = false

        if tag == "!MUS" or tag == "!SFX" then --- parse audio
            
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

        if tag == "!BG" or tag == "!SPR" then --- parse image
            

            checkForHide = string.match(script[currentLine], "hide")

            if checkForHide == nil then
                isHide = false
            elseif checkForHide == "hide" then
                isHide = true
            end

            if tag == "!BG" then
                if isHide == true then
                    currentImg = nil
                elseif isHide == false then
                    newImg = string.gsub(script[currentLine], tag .. " ", "") --- removes tag from line
                    currentImg = imgs[newImg]
                end
            end

            if tag == "!SPR" then
                if isHide == true then
                    currentSprite = nil
                elseif isHide == false then
                    if currentSprite ~= nil then
                        oldSprite = string.format(newSprite)
                    end

                    checkForX = string.match(script[currentLine], "x%d+")
                    checkForY = string.match(script[currentLine], "y%d+")

                    if checkForX ~= nil then
                        newX = string.gsub(checkForX, "x", "") --- gets just the number
                        newX = string.format(newX, "%d") --- formats as integer
                        script[currentLine] = string.gsub(script[currentLine], " " .. checkForX, "")
                        -- sprX = newX
                    end

                    if checkForY ~= nil then
                        newY = string.gsub(checkForY, "y", "") --- gets just the number
                        newY = string.format(newY, "%d") --- formats as integer
                        script[currentLine] = string.gsub(script[currentLine], " " .. checkForY, "")
                        -- sprY = newY
                    end

                    newSprite = string.gsub(script[currentLine], tag .. " ", "")

                    currentSprite = imgs[newSprite]
                    
                end
            end

            --- i love copypasting instead of figuring out functions yum

            table.remove(script, currentLine) --- removes line (for history purposes)
            --- limitation: last image remains on screen always

            parseTags()
        end

        if chars[tag] ~= nil then --- parse nametag
                --- this checks if tag exists in the chars table. lua uses ~= instead of !=
            -- hasNametag = true --- killed this thought
            script[currentLine] = string.gsub(script[currentLine], tag, chars[tag] .. divider) --- source string, pattern to match, replacement
        end
    end
end



function moveSprite()
    --- this function is horrendous and i'm sorry
    --- this thing gave me much more trouble than i anticipated

    if newX ~= nil and sprX ~= nil then --- if both have x coordinates
        if oldSprite == newSprite then --- if using the same sprite
            newX = string.format(newX, "%d") --- these should have already been numbers idk why i got errors
            sprX = string.format(sprX, "%d")
            if newX < sprX then
                sprX = sprX - (sprX - newX) / animationSpeed
            elseif newX > sprX then
                sprX = sprX + (sprX + newX) / animationSpeed
            end
        else
            sprX = newX
        end
    end

    if newY ~= nil and sprY ~= nil then --- if both have y coordinates
        if oldSprite == newSprite then
            newY = string.format(newY, "%d")
            sprY = string.format(sprY, "%d")
            if newY < sprY then
                sprY = sprY - (sprY - newY) / animationSpeed
            elseif newY > sprY then
                sprY = sprY + (sprY + newY) / animationSpeed
            end
        else
            sprY = newY
        end
    end
end

function advanceScript()
    if gamestate == "menu" then
        currentLine = 1
        gamestate = "game"
        return
    end

    if currentLine < maxLines and gamestate == "game" then
        currentLine = currentLine + 1 --- advances script
        parseTags() --- so it only parses when the game updates instead of every frame
    end

    if currentLine >= maxLines then
        gamestate = "end" --- end the game
    end
end

function returnScript()
    if currentLine > 1 and gamestate == "game" then
        currentLine = currentLine - 1
    end
    --- aww yeahh rudimentary history babey
    --- possibility: set a different / fainter color for seen text
    --- and store the "present" line to know when to change color back to normal
end

function autoScript(dt)
    timer = timer + dt
    print(autoSpeed * (string.len(script[currentLine]) / 100))
    print(string.len(script[currentLine]))
    if timer >= autoSpeed * (string.len(script[currentLine]) / 100) and timer >= 2 then
        advanceScript()
        timer = 0
    end
end


--------------------------
--- CONTROLS -------------
--------------------------

function love.update(dt)
    if script[currentLine] == nil and gamestate == "game" then
        gamestate = "end"
        return
    end

    moveSprite()

    if auto == true then
        autoScript(dt)
    end

    function love.keypressed( key )
        if key == "return" or key == "down" then
            advanceScript()
        end

        if key == "up" then
            if auto == true then auto = false end
            returnScript()
        end

        if key == "a" then
            auto = not auto
        end

        if key == "1" then
            autoSpeed = slowSpeed
        end

        if key == "2" then
            autoSpeed = defaultSpeed
        end
        
        if key == "3" then
            autoSpeed = fastSpeed
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
            if gamestate ~= "game" then
                love.event.quit()
            end

            if gamestate == "game" then
                    if currentMus ~= nil and currentMus:isPlaying() then
                        love.audio.stop(currentMus)
                    end
                    
                    if currentSfx ~= nil and currentSfx:isPlaying() then
                        love.audio.stop(currentSfx)
                    end
                gamestate = "menu"
                reset()
            end
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

    if gamestate == "menu" then
        
        love.graphics.printf(title, textCoords[1], 50, textWidth, "left")
        love.graphics.printf(menuText, textCoords[1], 180, textWidth, "left")

        return
    end

    if gamestate == "end" then
        love.graphics.printf(endText, textCoords[1], 80, textWidth, "center")
        return
    end


    if currentImg ~= nil then
        love.graphics.draw(currentImg, imgX, imgY)
    end

    if currentSprite ~= nil then
        love.graphics.draw(currentSprite, sprX, sprY)
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