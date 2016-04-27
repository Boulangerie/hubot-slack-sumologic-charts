_               = require 'lodash'
Promise         = require 'bluebird'
os              = require 'os'
fs              = Promise.promisifyAll(require('fs'))

class FileHelper
  constructor: () ->
    @DIR_PATH = "#{os.tmpdir()}/sumograph"
    @DIR_PROMISE = @createDir()

  write: (filename, data) ->
    filepath = @getPath(filename)
    @DIR_PROMISE
      .then(() ->
        fs.writeFileAsync(filepath, data)
      )
      .then(() ->
        return filename
      )
      .catch((error) ->
        return error
      )

  read: (filename) ->
    filepath = @getPath(filename)
    @DIR_PROMISE
      .then(() ->
        fs.readFileAsync(filepath)
      )

  getPath: (filename) ->
    return "#{@DIR_PATH}/#{filename}"

  clean: () ->
    fs
      .readdirAsync(@DIR_PATH)
      .then((files) =>
        filesPromises = []
        _.forEach(files, (filename) =>
          filesPromises.push(fs.unlinkAsync("#{@getPath(filename)}"))
        )
        Promise.all(filesPromises)
      )

  createDir: () ->
    fs
      .mkdirAsync(@DIR_PATH)
      .catch((error) =>
        if(error.code isnt 'EEXIST')
          return Promise.reject(error)
        else
          return Promise.resolve(true)
      )


module.exports = new FileHelper()
