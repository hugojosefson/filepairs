path = require 'path'
fs = require 'fs'

class Orphaned
  constructor: ->
    @jpegRegEx = /\.jpe?g$/i
    @nefRegEx = /\.nef$/i

  printOrphanedNefsInDir: (dir = '.') ->
    files = @extractFilesFromDir dir
    orphanedNefs = findOrphanedNefs files
    for nef in orphanedNefs
      console.log nef

  findOrphanedNefs: (files) ->
    jpegShorts = @extractJpegShorts files
    nefs = @extractNefs files
    orphanedNefs = @extractOrphanedNefs jpegShorts, nefs

  extractJpegShorts: (files) ->
    (file.replace(@jpegRegEx, '') for file in files when @jpegRegEx.test(file))

  extractNefs: (files) ->
    (file for file in files when @nefRegEx.test(file))

  extractOrphanedNefs: (jpegShorts, nefs) ->
    (nef for nef in nefs when !(@findNewLocationForNefInJpegShorts(nef, jpegShorts)))

  findNewLocationForNefInJpegShorts: (nef, jpegShorts) ->
    @shortNef(nef) in jpegShorts

  shortNef: (filename) ->
    path.basename filename, '.nef'

  extractFilesFromDir: (dir) ->
    fs.readdirSync dir

module.exports = Orphaned