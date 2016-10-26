WidgetFinder    = require './scripts/helpers/sumologic/widgetFinder'
GraphBuilder    = require './scripts/helpers/graphs/graphBuilder'
HubotTeleporter = require './scripts/helpers/hubot-tools/hubotTeleporter'
HubotSumoMemory = require './scripts/helpers/hubot-tools/hubotSumoMemory'
FileHelper      = require './scripts/helpers/utils/fileHelper'
sendToSlack     = require './scripts/helpers/utils/sendToSlack'

module.exports = (robot) ->
  HubotTeleporter.enter(robot)
  HubotSumoMemory.startLearning()

  robot.respond /lobotomize sumo/i, (result) ->
    HubotSumoMemory.eraseMemory()
    result.reply "Hubot forget his tricks about sumo :disappointed:"

  robot.respond /sumo (.*)/i, (result) ->
    widget = new WidgetFinder(result.match[1], robot)
    if widget.exists()
      robot.logger.info "Sumo Graph : Start"
      result.reply "Sure ! I process it and send you this one here !"
      widget
      .getData()
      .then((widgetData) ->
        return GraphBuilder.generateSvgChart(widget.name, widget.config, widgetData)
      )
      .then((svgName) ->
        return GraphBuilder.exportSvgToPng(svgName)
      )
      .then((pngName) ->
        filePath = FileHelper.getPath(pngName)
        sendToSlack(filePath, result.message)
      )
      .then((sent) ->
        robot.logger.info "File : #{sent.filepath} sent"
        robot.logger.info "to : #{sent.channel}/#{sent.room}"
        return FileHelper.clean()
      )
      .then(() ->
        robot.logger.info "All files clear ! Graph generation done !"
        robot.logger.info "Sumo Graph : End"
      )
      .catch((e) ->
        result.reply "Something bad happen ! Seems I can't send you your graph :disappointed:"
        robot.logger.error "Can't send the widget due to the following error"
        robot.logger.error e
        robot.logger.info "Sumo Graph : End"
      )
    else
      result.reply "I don't know this widget sorry... :disappointed:"
      robot.logger.info "Sumo Graph : End"
