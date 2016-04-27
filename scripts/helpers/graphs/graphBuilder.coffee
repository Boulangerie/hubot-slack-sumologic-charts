svg2png                     = require 'svg2png'
FileHelper                  = require '../utils/fileHelper'
StackedBarChart             = require '../../graphs/stackedBarChart'
PieChart                    = require '../../graphs/pieChart'
LinesChart                  = require '../../graphs/linesChart'
TimecounterChart            = require '../../graphs/timecounterChart'
CounterChart                = require '../../graphs/counterChart'

class GraphBuilder
  constructor: () ->

  generateSvgChart: (chartName, config, widgetData) ->
    svg = @getChart(chartName, config, widgetData)
    FileHelper.write("#{chartName}.svg", svg)

  exportSvgToPng: (svgName, pngName = "") ->
    pngName = svgName.replace('.svg', '.png')

    FileHelper
      .read(svgName)
      .then(svg2png)
      .then((pngData) ->
        FileHelper.write(pngName, pngData)
      )
      

  getChart: (name, config, widgetData) ->
    chart = {}
    if (config.type is "stackedBar")
      chart = new StackedBarChart(name, config, widgetData)
    else if (config.type is "pie")
      chart = new PieChart(name, config, widgetData)
    else if (config.type is "lines")
      chart = new LinesChart(name, config, widgetData)
    else if (config.type is "timecounter")
      chart = new TimecounterChart(name, config, widgetData)
    else if (config.type is "counter")
      chart = new CounterChart(name, config, widgetData)
    return chart.getSvg()

module.exports = new GraphBuilder()
