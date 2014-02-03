# OpenXcom Namelist Generator

A small command-line utility for generating namelist files for [OpenXcom](http://openxcom.org) from a list of (nick)names.

## Installation

1. Make sure you have [node.js](http://nodejs.org) installed.
2. Run `npm install -g openxcom-namegen` from the command line.

## Usage

```

    Usage: openxcom-namegen [options] namefile

  Generate OpenXcom namelist files from a list of (nick)names.
  Namefile defaults to names.txt. Names are spread evenly across all countries
  unless the -d/--dupe option is specified.

  Options:

    -h, --help    Show this help.
    -o, --output  Output directory. [SoldierName]
    -d, --dupe    Duplicate all names across all countries. [false]
    -s, --stable  Generate names for stable version instead of nightly. [false]

```

By default, the namefiles will be placed into a `SoldierName` directory. After generation, you can simply copy the directory to your `[OpenXcom Path]\data` directory - you'll probably want to back up the original `SoldierName` directory first!

**IMPORTANT:** It is recommended that you use the nightly builds for this, as they support namelists without last names. You can use the `-s/--stable` flag to generate namelist files for the latest stable (0.9), but your soldier names will end in two empty spaces in that case.

## Namefile

Your namefile (`names.txt` by default) should have the following format:

```
name1
name2
name3
name4
```

And so on. One name per line with nothing else. Avoid using quotes (`"`). These names will be used as last names in the game, with the first names left empty for everyone. If you don't have a lot of names, usage of the `-d/--dupe` option is recommended.