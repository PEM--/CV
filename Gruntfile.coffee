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

    less:
      all:
        files:
          'tmp/<%= pkg.name %>.css': 'app/css/<%= pkg.name %>.less'

    concat:
      js:
        src: [
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
      pdf:
        options:
          message: 'PDF is baked'

  # PDF task
  grunt.registerTask 'pdf', 'Print site as PDF', ->
    # Special initialization
    phantomjs = (require 'grunt-lib-phantomjs').init grunt
    # Handy functions
    path = require 'path'
    asset = path.join.bind null, __dirname, 'phantomjs_utils'
    phantomjs.on 'pdf.ok', (msg) ->
      grunt.warn 'Started?'
      console.log 'Started?'
      grunt.task.run 'notify:pdf'
    # Cleanup and use an OS notification
    phantomjs.on 'pdf.done', ->
      grunt.warn 'Done?'
      console.log 'Done?'
      grunt.task.run 'notify:pdf'
      phantomjs.halt()
      done()
    # Pass-through console.log statements
    phantomjs.on('console', console.log.bind(console))
    # Error handling
    phantomjs.on 'fail.load', (url) ->
      phantomjs.halt()
      grunt.warn "PhantomJS unable to load: " +
        "#{url}. Did your project build properly?"
    phantomjs.on 'fail.timeout', ->
      console.log asset 'raterize.js'
      phantomjs.halt()
      grunt.warn 'PhantomJS timed out.'
    # Tell Grunt that the task is asynchronous
    done = @.async()
    # Spawn a PhantomJS on the build directory
    #phantomjs.spawn 'dist/index.html',
    phantomjs.spawn 'test.html',
      options:
        timeout: 1000
        inject: asset 'rasterize.js'
      done: (err) ->
        grunt.warn 'Inner done?'
        console.log 'Done is done?'
        done()

  # Build tasks
  grunt.registerTask 'build', [
    'less'
    'concat'
    'uglify'
    'cssmin'
    'jade'
    'notify:build'
  ]

  # Default task
  grunt.registerTask 'default', [
      'clean', 'copy', 'imagemin', 'svgmin', 'build'
      'express', 'notify:express', 'open', 'watch'
    ]
