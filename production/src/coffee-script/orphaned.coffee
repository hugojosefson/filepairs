class Orphaned
  go: ->
    fs = require 'fs'

    jpegRegEx = /\.jpe?g$/i
    nefRegEx = /\.nef$/i

    files = fs.readdirSync '.'
    jpegShorts = (file.replace(jpegRegEx, '') for file in files when jpegRegEx.exec(file))
    nefs = (file for file in files when nefRegEx.exec(file))

    shortNef = (filename) -> filename.replace(nefRegEx, '')
    orphanedNefs = (nef for nef in nefs when !(shortNef(nef) in jpegShorts))

    for nef in orphanedNefs
      console.log nef

