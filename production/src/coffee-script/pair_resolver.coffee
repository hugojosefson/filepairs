Walker = require 'walker'
path = require 'path'

exports.resolveDirectory = (dirname = '.', cb = ->) ->
  
  if cb is null
    return
  
  jpegRegEx = /\.jpe?g$/i
  nefRegEx = /\.nef$/i

  # What is left to handle.
  # Full path/filenames.
  queue =
    jpegShorts: []
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
    if isJpeg file
      queue.jpegShorts.push file.replace(jpegRegEx, '')
    if isNef file
      queue.nefs.push file
  )
  .on('error', (err, entry, stat) ->
    console.log "Got error #{err} on entry #{entry}"
    errors.push {err, entry, stat}
  )
  .on('end', () ->
    if errors.length is 0
      errors = null
    if errors
      console.log "There were errors, so not all files/directories were traversed."
      console.log "No actions are defined."
    else
      console.log "All files traversed."
      defineActions queue, actions
    cb(errors, {queue, actions})
  )

  isJpeg = (file) ->
    jpegRegEx.test path.extname(file)

  isNef = (file) ->
    nefRegEx.test path.extname(file)

  defineActions = (queue, actions) ->
    for nef in queue.nefs
      null #TODO fill in actions

  return

prettyJson = (string) ->
  JSON.stringify string, null, 2

arguments = process.argv.splice(2)
exports.resolveDirectory(arguments[0], (errors, {queue, actions}) ->
    console.log "Queue was: #{prettyJson queue}\n"
    console.log "Errors were: #{prettyJson errors}\n"
    console.log "Actions are: #{prettyJson actions}\n"
)