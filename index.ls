require 'shelljs/global'
yaml = require 'js-yaml'
argv = require \optimist
  .options \h do
    alias: \help
    default: false
    type: \boolean
  .options \o do
    alias: \output
    default: "SoldierName"
    type: \string
  .options \d do
    alias: \dupe
    default: false
    type: \boolean
  .options \s do
    alias: \stable
    default: false
    type: \boolean
  .argv

usage = """
\n    Usage: openxcom-namegen [options] namefile

  Generate OpenXcom namelist files from a list of (nick)names.
  Namefile defaults to names.txt. Names are spread evenly across all countries
  unless the -d/--dupe option is specified.

  Options:

    -h, --help    Show this help.
    -o, --output  Output directory. [SoldierName]
    -d, --dupe    Duplicate all names across all countries. [false]
    -s, --stable  Generate names for stable version instead of nightly. [false]

"""

if argv.help
  console.log usage
  process.exit 0

name = argv._.0 or "names.txt"
if not test \-f name
  console.log "Error: Input file not found. Showing help.\n#usage"
  process.exit 1

names = cat name .replace /^\ufeff/ '' .replace /\r\n|\r/g '\n' .split '\n'


countries-stable = <[
  American
  British
  Czech
  Danish
  Finnish
  French
  German
  Hungarian
  Italian
  Japanese
  Polish
  Portuguese
  Romanian
  Russian
  Spanish
  Swedish
]>

countries = <[
  American
  Arabic
  Belgium
  British
  Chinese
  Congolese
  Czech
  Danish
  Dutch
  Ethiopian
  Finnish
  French
  German
  Greek
  Hindi
  Hungarian
  Irish
  Italian
  Japanese
  Kenyan
  Korean
  Nigerian
  Norwegian
  Polish
  Polynesia
  Portuguese
  Romanian
  Russian
  Slovak
  Spanish
  Swedish
  Turkish
]>

if argv.stable
  countries = countries-stable

data = {}
for c in countries
  data[c] = {male-first: [], female-first: []}
  if argv.stable
    data[c].male-last = [" "]
    data[c].female-last = [" "]

# shuffle an array with Fisher-Yates
shuffle = ->
  arr = it.slice! # copy the array instead of modifying the original
  m = arr.length
  while m
    i = Math.floor Math.random! * m--
    t = arr[m]
    arr[m] = arr[i]
    arr[i] = t

  arr

country-queue = shuffle countries
last-country = void

next-country = ->
  if not country-queue.length
    country-queue := shuffle countries
    while country-queue.0 is last-country
      country-queue := shuffle countries
  last-country := country-queue.pop!

genders = [\maleFirst, \femaleFirst]
gender = -> genders[Math.random!*2.|.0]

for name in names
  if argv.dupe
    for c in countries
      data[c].male-first.push name
      data[c].female-first.push name
  else
    data[next-country!][gender!].push name

if not test \-e argv.output
  mkdir argv.output

for c in countries
  yml = yaml.safe-dump data[c]
  yml.to "./#{argv.output}/#c.nam"