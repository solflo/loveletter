#!/usr/bin/env lua

script = {}
syntaxTags = {"!MUS", "!SFX", "!BG", "!SPR"}
wc = 0 --- word count
lc = 0 --- line count

function syntaxCheck()
    for _, syntax in ipairs(syntaxTags) do
        if tag == syntax then 
            isSyntax = true
        end
    end
    return isSyntax
end

for line in io.lines("script.txt") do
    comment = string.match(line, "^!%-%-")

    if comment == nil then --- if not a comment

        tag = string.match(line, "^!%w+") --- now we check for syntax

        syntaxCheck()

        if isSyntax ~= true then --- if not syntax
            lc = lc + 1 --- count the line

            if tag ~= nil then --- if there is a tag (it must be a character tag)
                wc = wc - 1 --- a little brute forced lol
            end
            local _, t = string.gsub(line, "%S+", "")
            wc = wc + t
        end
    end
end

print("word count: " .. wc)
print("line count: " .. lc)