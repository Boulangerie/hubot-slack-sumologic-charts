_               = require 'lodash'
Promise         = require 'bluebird'
HubotSumoMemory = require '../hubot-tools/hubotSumoMemory'
SumologicHelper = require '../sumologic/sumologicHelper'

class WidgetFinder
  constructor: (@name, @robot) ->
    @config = _.get(HubotSumoMemory.getMemory(), @name)
    if _.isUndefined(@config)
      robot.logger.error "The widget '#{@name}' isn't mapped yet !"

  exists: () ->
    not _.isUndefined(@config)

  getData: () ->
    SumologicHelper
      .getDashboardData(@config.dashboardId)
      .then((dashboardData) =>
        widgetData = _.find(dashboardData, {'id': @config.widgetId})
        if(!_.isUndefined(widgetData))
          return widgetData
        else
          return Promise.reject("Widget not found !")
      )

module.exports = WidgetFinder
