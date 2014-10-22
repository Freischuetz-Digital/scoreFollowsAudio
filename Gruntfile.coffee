module.exports = (grunt) ->

  'use strict'

  # Load plugins. 
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-install-dependencies'
  grunt.loadNpmTasks 'grunt-bower-cli',
  grunt.loadNpmTasks 'grunt-contrib-jshint'

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    uglify: 
      dev:
        options: 
          mangle: false
          banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'      
        files: 
          'dist/<%= pkg.name %>.min.js': [ 'dist/<%= pkg.name %>.js' ]

    #coffee:
      #compile:
        #files:
          #'dist/<%= pkg.name %>.js': ['src/*.coffee']

    connect:
      server:
        options:
          port: 8000
          hostname: "localhost"
          open: 'http://localhost:8000/test/index.html'
          

    watch:
      scripts:
        files: ['**/*.js']
        tasks: ['jshint']
        options:
          spawn: false
    
      #scripts:
        #files: ['src/*.coffee', 'less/*.less']
        #tasks: ['coffee']
        #options:
          #livereload: true
      #styles:
        #files: ['less/*.less']
        #tasks: ['less']
        #options:
          #nospawn: true

    #less:
      #dev:
        #files:
          #'css/main.css': 'less/main.less'

    concat:
      bower_js:
        options:
          separator: "\n"
        src: ['bower_components/jquery/dist/jquery.min.js', 
              'bower_components/bootstrap/dist/js/bootstrap.min.js',
              'bower_components/bootstrap/js/tabs.js',
              'bower_components/d3/d3.min.js']
              #'bower_components/verovio/index.js']
        dest: 'dist/bower.js'

    copy:
      src:
        files: [{expand: true, flatten: true, cwd: 'src/', src: ['**'], dest: 'dist/'}]
      #fonts:
       # files: [{expand: true, cwd: 'bower_components/bootstrap/dist/fonts/', src: ['*'], dest: 'fonts/'}]


  # Task(s).
  grunt.registerTask 'default', ['copy','concat', 'uglify']
  grunt.registerTask 'run', ['connect', 'watch']
  grunt.registerTask 'build', ['install-dependencies']
