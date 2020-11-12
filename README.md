# Lore

Merry color scheme inspired by some of the colors found in the cockpit of
the Mandalorian's ship in some random scene that I can't seem to find again.

## Installation

Installation using Vundle:

    Plug 'strange/vim-lore'

## Usage

Enable the color scheme:

    colorscheme lore

n.b. The scheme was designed for true color terminal emulators. It does a
decent (well, maybe not quite) job of automatically finding alternative colors
for terminals that support only 256 colors, but terminal warriors will probably
want to use something like Kitty and enable `termguicolors` for the full
experience:

    set termguicolors

## Screenshots

Vim:

![JavaScript](/screenshots/vim.png)

JavaScript:

![JavaScript](/screenshots/js.png)

Python:

![JavaScript](/screenshots/python.png)

Erlang:

![JavaScript](/screenshots/erlang.png)

## Other applications

### Kitty

Include custom colors in your `.conf/kitty/kitty.conf`:

    include /path/to/vim-lore/apps/kitty.conf
