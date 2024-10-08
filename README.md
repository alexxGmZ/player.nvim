# player.nvim

A Neovim plugin that control media players that supports [MPRIS](https://wiki.archlinux.org/title/MPRIS)
using playerctl.

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
