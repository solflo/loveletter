#!/usr/bin/env lua

script = {}
wc = 0 --- word count
lc = 0 --- line count

for line in io.lines("script.txt") do
    if string.match(line, "^!--") == nil then --- if not a comment
        lc = lc + 1

        if string.match(line, "^!") == nil then --- if the line does not start with '!'
            local _,t = string.gsub(line, "%S+", "")
            wc = wc + t
        end
    end
end

print("word count: " .. wc)
print("line count: " .. lc)