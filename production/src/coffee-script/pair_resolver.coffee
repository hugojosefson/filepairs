Walker = require 'walker'

class PairResolver
  constructor: ->

  resolveDirectory: (dirname = '.', cb = ->) ->
    # What is left to handle.
    # Full path/filenames.
    queue =
      jpegs: []
      nefs: []

    # Key for each action is the nef path/filename.
    # Value is where to move it, or null to delete it.
    actions = {}

    # Each entry is a map of {err, entry, stat}
    errors = []

    Walker(dirname).filterDir( (dir, stat) ->
      if errors.length > 0
        return false
      if dir in ['.git', 'node_modules', '.idea']
        console.warn("Skipping #{dir} and children")
        return false
      return true
    )
    .on('file', (file, stat) ->
      console.log "Got file: #{file}"
    )
    .on('error', (err, entry, stat) ->
      console.log "Got error #{err} on entry #{entry}"
      errors.push {err, entry, stat}
    )
    .on('end', () ->
      console.log "All files traversed."
      cb()
    )

module.exports = PairResolver

new PairResolver().resolveDirectory()