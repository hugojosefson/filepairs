Walker = require 'walker'

class PairResolver
  constructor: ->

  resolveDirectory: (dirname = '.') ->
    # What is left to handle.
    # Full path/filenames.
    queue =
      jpegs: []
      nefs: []

    # Key for each action is the nef path/filename.
    # Value is where to move it, or null to delete it.
    actions = {}

    Walker(dirname).filterDir( (dir, stat) ->
      if dir in ['.git', 'node_modules', '.idea']
        console.warn("Skipping #{dir} and children")
        return false
      return true
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