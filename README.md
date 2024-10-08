# player.nvim

A Neovim plugin that control media players that supports [MPRIS](https://wiki.archlinux.org/title/MPRIS)
using playerctl.

<br>

## Why?

I made this plugin mainly for myself. I don't want to leave the editor just to pause,
play, or skip tracks while coding, as it really disrupts my flow. If I need to do
something more intensive with the music player, that should be the only reason to switch
back to the music player application. For that reason, I don't intend for Neovim to
become a music player at all.

<br>

**Dependencies:**

* [playerctl](https://github.com/altdesktop/playerctl)

<br>

## Install

**Lazy**

```lua
{
  "alexxGmZ/player.nvim",
  cmd = "Player",
  config = function()
     require("player").setup()
  end
}
```

## Usage

**Playback commands**

```
next
previous
pause
play
play-pause
```

Display the status of the current active player.

```
:Player
```

Display the status of the selected player.

```
:Player <selected_player>
```

Control player playback

```
:Player <playback_command>
:Player <selected_player> <playback_command>
```

## Configuration
```lua
require("player").setup({
  -- Overrides the plugin's default list of supported players.
  supported_players = {
    "cmus",
    "spotify",
    "firefox",
    "mpv"
  }
})
```
