class Orphaned
  constructor: ->
    @jpegRegEx = /\.jpe?g$/i
    @nefRegEx = /\.nef$/i

  printOrphanedNefsInDir: (dir = '.') ->
    orphanedNefs = findOrphanedNefsInDir dir
    for nef in orphanedNefs
      console.log nef

  findOrphanedNefsInDir: (dir) ->
    files = @extractFilesFromDir dir
    jpegShorts = (file.replace(@jpegRegEx, '') for file in files when @jpegRegEx.test(file))
    nefs = (file for file in files when @nefRegEx.test(file))

    shortNef = (filename) -> filename.replace(@nefRegEx, '')
    orphanedNefs = (nef for nef in nefs when !(shortNef(nef) in jpegShorts))

  extractFilesFromDir: (dir) ->
    fs = require 'fs'
    fs.readdirSync dir
