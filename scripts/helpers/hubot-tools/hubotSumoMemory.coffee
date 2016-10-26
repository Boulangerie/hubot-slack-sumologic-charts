_               = require 'lodash'
Promise         = require 'bluebird'
FormData        = require 'form-data'
HubotTeleporter = require './hubotTeleporter'

class HubotSumoMemory
  constructor: () ->
    @FILENAME_TO_WATCH = "hubot-sumo-lesson"
    @FILETYPE_TO_WATCH = "JavaScript/JSON"
    @BRAIN_KEY = "hubot_sumo_memory"

  startLearning: () ->
    robot = HubotTeleporter.out()
    robot.adapter.client.ws.on "message", (data, flag) =>
      @watchKnowledge(data, flag)

  watchKnowledge: (data, flag) ->
    message = JSON.parse(data)
    if (@isKnowledgeFile(message))
      @fetchLesson(message.file.url_private_download)
        .then((fileContent) =>
          @learnNewTricks(fileContent)
        )
        .then(() =>
          @noticeUploader('success', message)
        )
        .catch((error) =>
          @noticeUploader('error', message, error)
        )

  isKnowledgeFile: (message) ->
    message.type is "file_shared" and
    message.file.name.indexOf(@FILENAME_TO_WATCH) >= 0 and
    message.file.pretty_type is @FILETYPE_TO_WATCH

  fetchLesson: (lessonUrl) ->
    new Promise((resolve, reject) =>
      HubotTeleporter
        .out()
        .http(lessonUrl)
        .header('Authorization', "Bearer #{process.env.HUBOT_SLACK_TOKEN}")
        .get() (err, res, body) ->
          try
            body = JSON.parse(body)
          catch e
            err = "Impossible to parse json file from Slack"

          if err
            reject(err)
          else
            resolve(body)
    )

  learnNewTricks: (jsonKnowledge) ->
    memory = @getMemory()
    _.extend(memory, jsonKnowledge)
    @setMemory(memory)

  noticeUploader: (type, message, detail) ->
    loggerType = if type is "success" then "info" else "error"
    userMessage = if type is "success" then "I learn a new lessons for sumologic ! Give me more !" else "I can't learn from your lesson..."
    logMessage = if type is "success"then  "Hubot learn new tricks for sumo" else "Hubot can't learn new tricks for sumo"

    HubotTeleporter.out().logger[loggerType] logMessage

    if detail
      detailMessage = _.attempt(() ->
        detail.toString()
      )
      HubotTeleporter.out().logger[loggerType] detailMessage

    @sendMessageToUploader(message.file.user, userMessage)

  sendMessageToUploader: (uploaderID, message) ->
    new Promise((resolve, reject) ->
      form = new FormData()
      form.append('token', process.env.HUBOT_SLACK_TOKEN)
      form.append('channel', uploaderID)
      form.append('text', message)

      form.submit("https://slack.com/api/chat.postMessage", (err, res) ->
        if err
          reject(err)
        else
          resolve(true)
      )
    )

  getMemory: () ->
    memory = HubotTeleporter
      .out()
      .brain.get @BRAIN_KEY

    if(_.isNull(memory))
      @eraseMemory()
      memory = {}

    return memory


  setMemory: (newMemory) ->
    HubotTeleporter
      .out()
      .brain.set @BRAIN_KEY, newMemory

  eraseMemory: () ->
    @setMemory({})

module.exports = new HubotSumoMemory()
