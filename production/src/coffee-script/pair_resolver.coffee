Walker = require 'walker'
path = require 'path'

exports.resolveDirectory = (dirname = '.', cb = ->) ->
  
  if cb is null
    return
  
  jpegRegEx = /\.jpe?g$/i
  nefRegEx = /\.nef$/i

  # What is left to handle.
  queue =
    jpegShortNameToDirName: {}
    nefToShortName: {}

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
      dirname = path.dirname file
      shortname = shortName file
      queue.jpegShortNameToDirName[shortname] = dirname
    if isNef file
      queue.nefToShortName[file] = shortName file
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

  shortName = (file) ->
    extension = path.extname file
    path.basename file, extension

  defineActions = (queue, actions) ->
    for nef, shortName of queue.nefToShortName
      console.log "defineActions: {nef, shortName} = #{JSON.stringify({nef, shortName})}"
      if queue.jpegShortNameToDirName.hasOwnProperty(shortName)
        jpegDirName = queue.jpegShortNameToDirName[shortName]
        nefDirName = path.dirname nef
        if nefDirName == jpegDirName
          # all good. nef and jpeg already in the same dir.
        else
          actions[nef] = jpegDirName
      else
        actions[nef] = null

  return

prettyJson = (string) ->
  JSON.stringify string, null, 2

arguments = process.argv.splice(2)
exports.resolveDirectory(arguments[0], (errors, {queue, actions}) ->
    console.log "Queue was: #{prettyJson queue}\n"
    console.log "Errors were: #{prettyJson errors}\n"
    console.log "Actions are: #{prettyJson actions}\n"
)