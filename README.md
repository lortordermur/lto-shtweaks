## LorTorDeRMur’s Shell Utilities and Tweaks

This is a collection of handy shell aliases and functions in a sourceable file. For background, my own aliases file had grown to embarrassing dimensions over more than two decades and was largely unorganized and full of cruft. Therefore, as an evening project, I transferred what I felt could be shared with the world into a neatly structured file which is offered here for copy and paste or download.

### How to import the file into your shell initialization files

Download or clone `lto-shtweaks.sh` to your computer and copy or symlink it to your home directory. At the bottom of `.bashrc`, `.zshrc` or whatever file your shell reads on interactive startup, add:

```sh
if [ -f ~/lto-shtweaks.sh ]; then
  . ~/lto-shtweaks.sh
fi
```

or

```sh
source ~/lto-shtweaks.sh
```
