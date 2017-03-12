# Tyler's Dotfiles <sup><sub><sup><sub><sup><sub>(and other system configuration files)</sub></sup></sub></sup></sub></sup>

This repository contains useful configuration files and scripts that I use on my personal systems. Feel free to use it how you'd like. It's designed to work with GNU Stow.

## Installation

Clone the directory to someplace useful. I typically choose `$HOME/.dotfiles`

Then use `stow` to symlink the subdirectories and files to the correct place

```bash
cd .dotfiles
stow ./home                # As user
stow ./etc --target=/etc   # As root
...
```
