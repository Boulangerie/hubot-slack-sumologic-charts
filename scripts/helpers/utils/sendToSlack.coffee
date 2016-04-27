fs          = require 'fs'
process     = require 'process'
FormData    = require 'form-data'
Promise     = require 'bluebird'
slackToken  = process.env.HUBOT_SLACK_TOKEN

sendToSlack = (filepath, slackMessage) ->
  new Promise((resolve, reject) ->
    form = new FormData()
    form.append('token', slackToken)
    form.append('file', fs.createReadStream(filepath))
    form.append('channels', "#{slackMessage.rawMessage.channel}")

    form.submit("https://slack.com/api/files.upload", (err, res) ->
      if err
        reject(err)

      resolve({
        channel : slackMessage.rawMessage.channel
        room: slackMessage.room
        filepath : filepath
      })
    )
  )

module.exports = sendToSlack
