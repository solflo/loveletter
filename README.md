# love letter engine

well so this here is a tiny engine for kinetic visual novels.

inspired by freya campbell's [videotome](https://communistsister.itch.io/videotome), written in love2d by [solflo](https://solflo.neocities.org/).

it's currently on v0.2 and rather janky. it'll be eternally kinda janky obvi but hopefully a little less so for v1. TODO includes checking if mouse == touch on touchscreens and a main menu and/or end screen. and nothing else. minification is the point.

## using

- script goes in ```script.txt```
- assets and everything else is in ```conf.lua```

### syntax

- all commands are preceded by ```!```. you can use one command per line.
- ```!BG name``` and ```!SPR name``` display images. ```!SPR``` (sprite) goes on top, and can be hidden with ```!SPR hide```
- ```!MUS name``` plays looping audio. can be stopped with ```!MUS stop```
- ```!SFX name``` plays audio once and can't be stopped
- ```!NAME``` prefixes the line with a nametag

## playing

- ```enter```, ```down arrow```, ```left click``` and ```scroll down``` advances text
- ```up arrow``` and ```scroll up``` display previous text. this won't affect images or audio
- ```f``` toggles fullscreen
- ```m``` toggles mute
- ```esc``` closes the game