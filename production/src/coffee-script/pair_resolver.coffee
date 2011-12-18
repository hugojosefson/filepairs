Walker = require 'walker'

class PairResolver
  constructor: ->

  resolveDirectory: (dirname = '.') ->
    Walker(dirname).filterDir( (dir, stat) ->
      if dir == '.git'
        console.warn('Skipping .git and children')
        return false
      return true
    )
    .on('entry', (entry, stat) ->
      console.log "Got entry: #{entry}"
    )
    .on('dir', (dir, stat) ->
      console.log "Got directory: #{dir}"
    )
    .on('file', (file, stat) ->
      console.log "Got file: #{file}"
    )
    .on('symlink', (symlink, stat) ->
      console.log "Got symlink: #{symlink}"
    )
    .on('blockDevice', (blockDevice, stat) ->
      console.log "Got blockDevice: #{blockDevice}"
    )
    .on('fifo', (socket, stat) ->
      console.log "Got socket: #{socket}"
    )
    .on('characterDevice', (characterDevice, stat) ->
      console.log "Got characterDevice: #{characterDevice}"
    )
    .on('error', (er, entry, stat) ->
      console.log "Got error #{er} on entry #{entry}"
    )
    .on('end', () ->
      console.log "All files traversed."
    )

module.exports = PairResolver

new PairResolver().resolveDirectory()