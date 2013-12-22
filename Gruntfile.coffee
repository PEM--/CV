# Grunt tasks
module.exports = (grunt) ->
  # Load all tasks except tasks requiring special initialization
  ((require 'matchdep').filterDev ['grunt-*', '!*phantomjs']).
    forEach grunt.loadNpmTasks

  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: [ 'dist', 'tmp' ]

    open:
      all:
        path: 'http://localhost:<%= express.all.options.port %>'

    copy:
      bootstrap_fonts:
        expand: true
        cwd: 'bower_components/bootstrap/dist/'
        src: ['fonts/*']
        dest: 'dist/css/'
      awesome_fonts:
        expand: true
        cwd: 'bower_components/font-awesome/'
        src: ['fonts/*']
        dest: 'dist/css/'
      #clowned:
        #expand: true
        #cwd: 'tmp'
        #src: ['*-*.jpg']
        #dest: 'dist/'

    less:
      all:
        files:
          'tmp/<%= pkg.name %>.css': 'app/css/<%= pkg.name %>.less'

    concat:
      js:
        src: [
          #'bower_components/jquery/jquery.min.js'
          #'bower_components/bootstrap/js/transition.js'
          #'bower_components/bootstrap/js/dropdown.js'
          #'bower_components/bootstrap/js/scrollspy.js'
          #'bower_components/bootstrap/js/button.js'
          #'bower_components/bootstrap/js/collapse.js'
          #'bower_components/bootstrap/js/carousel.js'
          #'bower_components/angular/angular.min.js'
          #'bower_components/angular-route/angular-route.min.js'
          #'app/js/app.js'
          #'app/js/controller.js'
          'app/js/<%= pkg.name %>/.js'
        ]
        dest: 'tmp/<%= pkg.name %>.js'

    uglify:
      js:
        src: 'tmp/<%= pkg.name %>.js'
        dest: 'dist/js/<%= pkg.name %>.js'

    svgmin:
      basic:
        files: [{
          expand: true
          cwd: 'app/img/'
          src: ['*.svg']
          dest: 'dist/img/'
          ext: '.svg'
        }]
      #clowned:
        #files: [{
          #expand: true
          #cwd: 'tmp/'
          #src: ['*.svg']
          #dest: 'tmp/minified/'
          #ext: '.min.svg'
        #}]

    imagemin:
      options:
        optimizationLevel: 7
        progressive: false
        interlaced: false
        pngquant: true
      basic:
        files: [{
            expand: true
            cwd: 'app/'
            src: ['img/*.{png,jpg,gif}']
            dest: 'dist/'
          }]

    #clowncar:
      #options:
        #sizes: [1280, 992, 768, 400]
      #all:
        #files: [{
            #expand: true
            #cwd: 'app/assets/'
            #src: ['*.jpg']
            #dest: 'tmp/'
            #ext: '.svg'
          #}
        #]

    cssmin:
      minify:
        files:
          'dist/css/<%= pkg.name %>.css': ['tmp/<%= pkg.name %>.css']

    jade:
      compile:
        options:
          pretty: false
        files:
          'dist/index.html': ['app/index.jade']

    #markdown:
      #options:
        #gfm: true
      #all:
        #files: [
            #expand: true
            #cwd: 'app/'
            #src: '*.md'
            #dest: 'dist/'
            #ext: '.html'
          #]

    express:
      all:
        options:
          port: 9000
          hostname: '0.0.0.0'
          bases: ['dist/']
          livereload: true

    watch:
      options:
        # Note: Livereload is not set in this task as it's already provided
        # the express server (the grunt task).
        livereload: false
      all:
        files: 'app/**'
        tasks: ['build']

    notify:
      build:
        options:
          message: 'Build is ready'
      express:
        options:
          message: 'Server is on'

  # Build tasks
  grunt.registerTask 'build', [
    'less'
    'concat'
    'uglify'
    'cssmin'
    #'clowncar'
    #'svgmin'
    #'copy'
    #'imagemin'
    'jade'
    #'markdown'
    'notify:build'
  ]
  # Default task
  grunt.registerTask 'default', [
      #'clean', 'copy', 'imagemin', 'svgmin', 'build', 'watch'
      'clean', 'copy', 'imagemin', 'svgmin', 'build'
      'express', 'notify:express', 'open', 'watch'
    ]
