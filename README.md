# love letter engine

well so this here is a tiny engine for kinetic visual novels. the focus is in easy and fast writing without the temptation to scope creep and complicate things with features, as well as keeping file sizes small and cute. the demo game appimage, for example, is just under 5mb, and i'm pretty sure most of that is the bundled font.

inspired by freya campbell's [videotome](https://communistsister.itch.io/videotome), written in love2d by [solflo](https://solflo.neocities.org/).

it's currently on v1.0 and rather janky. it was written in under 48 hours by someone who's never touched lua before. it'll be eternally kinda janky obvi but i might tweak things here and there as i use the thing and need features for myself (i'd love pixel-perfect scaling... and i am not using a library for that. minor sprite animation could be cute too[^1]). but _minification is the point_ and i've already scope crept with sprite positioning so don't hold your breath.

[^1]: see that's the problem with adding features: they start asking for other features. this or multiple sprite slots wouldn't have crossed my mind if i'd stuck with a single image slot, for the background!

## using

- script goes in ```script.txt```
- images and audio go in their respective folders (or not, this isn't automated. organize as you will)
- configuration is in ```conf.lua```
- engine is ```main.lua```. any fancier changes go there

### syntax

- all commands are preceded by ```!```, one command per line
- ```!BG name``` displays an image at a fixed position. can be hidden with ```!BG hide```
- ```!SPR name``` (sprite) goes on top. can be positioned with ```!SPR name x100 y100``` (either coordinate can be ommited). can be hidden with ```!SPR hide```
- ```!MUS name``` plays looping audio. can be stopped with ```!MUS stop```
- ```!SFX name``` plays audio once and can't be stopped
- ```!name``` prefixes the line with a nametag

### building

uh you're on your own there but [makelove](https://github.com/pfirsich/makelove) is very straightforward, at least on linux (and probably wsl too). love.js is hiiiideous out of the box but you can't win them all. i'm not making a template, but it's pretty easy to adjust things so it looks decent as an itch embed.

## playing

- ```enter```, ```down arrow```, ```left click``` and ```scroll down``` advance text
- ```up arrow``` and ```scroll up``` display previous text. this won't affect images or audio
- ```f``` toggles fullscreen
- ```m``` toggles mute
- ```esc``` closes the game