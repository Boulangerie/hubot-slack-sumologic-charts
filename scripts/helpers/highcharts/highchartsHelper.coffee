jsdom                       = require 'jsdom'
createElementNSForHighchart = require './createElementNSForHighchart'
#HighchartTheme              = require '../../graphs/themes/darkUnica.highchartheme'

class HighchartsHelper
  constructor: () ->

  getNewPlayground: (chartData) ->
    doc = jsdom.jsdom('<!doctype html><html><body><div id="container"></div></body></html>')
    win = doc.defaultView
    doc.createElementNS = createElementNSForHighchart.bind({doc: doc})
    Highcharts = require('highcharts')(win)
    Highcharts.setOptions({
      plotOptions: {
        series: {
          animation: false,
          dataLabels: {
            defer: false
          }
        }
      }
    })
#    HighchartTheme(Highcharts, doc)
    Highcharts.chart('container', chartData)

    return win.document.getElementById('container').childNodes[0].innerHTML

module.exports = new HighchartsHelper()
