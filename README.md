## LorTorDeRMur’s Shell Utilities and Tweaks

This is a collection of handy shell aliases and functions in a sourceable file. For background, my own aliases file had grown to embarrassing dimensions over more than two decades and was largely unorganized and full of cruft. Therefore, as an evening project, I transferred what I felt could be shared with the world into a neatly structured file which is offered here for copy and paste or download.

The file is occasionally updated as I add new aliases, so be sure to hit the watch button if you don't want to miss out. If you are also interested in staying up to date on my other projects, jump on my [Discord server](https://discord.gg/MQfdyjg).

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

### How to remove unneeded aliases

To undefine certain aliases sourced from `lto-shtweaks.sh` you can use the `unalias` command. Following the source statement, put

```sh
unalias alias-name…
```

It is possible to provide several aliases as parameters. If on the other hand you just wish to redefine an alias sourced from `lto-shtweaks.sh`, use the `alias` command again with another value.

### Reporting dysfunctional commands

If a command or function does not work for you, please create an issue on the [issue tracker](https://github.com/lortordermur/lto-shtweaks/issues) so we can work out a solution.
