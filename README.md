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

## Configuration

Honor terminal background color:

    let g:lore_respect_terminal_bg = 1

Color variations. Available options are: `soft`, `harmony`, `suave`, `brown`,
`crisp`, `alt` (defaults to `crisp`):

    let g:lore_mode = 'soft'

## Screenshots

Rust:

![Rust](/screenshots/rust.png)

Python:

![JavaScript](/screenshots/python.png)

Erlang:

![JavaScript](/screenshots/erlang.png)

Vim:

![JavaScript](/screenshots/vim.png)

JavaScript:

![JavaScript](/screenshots/js.png)

vimdiff:

![vimdiff](/screenshots/vimdiff.png)

## Other applications

### Kitty

Include custom colors in your `.conf/kitty/kitty.conf`:

    include /path/to/vim-lore/apps/kitty.conf

### Xresources (e.g. `xterm`, `rxvt`)

Add the contents of `apps/.Xresources` to your `~/.Xresources`, or, if you have
preprocessor such as `cpp` installed, include it:

    #include "/path/to/vim-lore/apps/.Xresources"

And reload with `xrdb`:

    $ xrdb ~/.Xresources

Make sure `xrdb` is not invoked with `-nocpp` if you're using includes (by your
display manager, if you're using one, for example).
