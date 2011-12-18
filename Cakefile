muffin = require 'muffin'

task 'build', 'compile production and test code', (options) ->
  # Run a map on all the files in the src directory
  muffin.run
      files: ['./production/src/coffee-script/*.coffee', './test/src/coffee-script/*.coffee']
      options: options
      map:
        '([a-z]+)/src/coffee-script/(.+).coffee' : (matches) ->
          src = matches[0]
          dest = "#{matches[1]}/src/js/#{matches[2]}.js"
          muffin.compileScript(src, dest, options)
