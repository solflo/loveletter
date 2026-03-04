# love letter engine

well so this here is a mini visual novel engine inspired by freya campbell's [videotome](https://communistsister.itch.io/videotome), written in love2d by [solflo](https://solflo.neocities.org/).

it's currently on v0.2 and rather janky. it'll be eternally janky obvi but hopefully a little less so for v1. TODO includes mouse controls and a main menu.

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

- ```enter``` or ```down arrow``` advances text
- ```up arrow``` displays previous text. this won't affect images or audio
- ```f``` toggles fullscreen
- ```esc``` closes the game