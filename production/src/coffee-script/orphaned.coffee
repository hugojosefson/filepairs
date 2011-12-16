class Orphaned
  constructor: (@dir = '.') ->
    @jpegRegEx = /\.jpe?g$/i
    @nefRegEx = /\.nef$/i

  go: ->
    fs = require 'fs'
    files = fs.readdirSync @dir
    jpegShorts = (file.replace(@jpegRegEx, '') for file in files when @jpegRegEx.test(file))
    nefs = (file for file in files when @nefRegEx.test(file))

    shortNef = (filename) -> filename.replace(@nefRegEx, '')
    orphanedNefs = (nef for nef in nefs when !(shortNef(nef) in jpegShorts))

    for nef in orphanedNefs
      console.log nef

