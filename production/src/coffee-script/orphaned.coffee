class Orphaned
  constructor: (@dir = '.') ->
    @fs = require 'fs'
    @jpegRegEx = /\.jpe?g$/i
    @nefRegEx = /\.nef$/i

  go: ->
    files = @extractFilesFromDir @dir
    jpegShorts = (file.replace(@jpegRegEx, '') for file in files when @jpegRegEx.test(file))
    nefs = (file for file in files when @nefRegEx.test(file))

    shortNef = (filename) -> filename.replace(@nefRegEx, '')
    orphanedNefs = (nef for nef in nefs when !(shortNef(nef) in jpegShorts))

    for nef in orphanedNefs
      console.log nef

  extractFilesFromDir: (dir) ->
    @fs.readdirSync @dir
