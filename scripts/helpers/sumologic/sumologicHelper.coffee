_               = require 'lodash'
Promise         = require 'bluebird'
HubotTeleporter = require '../hubot-tools/hubotTeleporter'
sumoToken       = process.env.SUMOLOGIC_TOKEN

class SumologicHelper
  constructor: () ->

  getDashboardData: (@dashboardId) ->
    new Promise((resolve, reject) =>
      HubotTeleporter.out()
        .http("https://api.sumologic.com/api/v1/dashboards/#{@dashboardId}/data")
        .header('Authorization', "Basic #{sumoToken}")
        .get() (err, res, body) ->
          body = JSON.parse(body)
          if err
            reject(err)
          else if not _.get(body, 'dashboardMonitorDatas', false)
            reject(body)
          else
            resolve(body.dashboardMonitorDatas)
    )


module.exports = new SumologicHelper()
