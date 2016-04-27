_                 = require 'lodash'
HighchartsHelper  = require '../helpers/highcharts/highchartsHelper'

class StackedBarChart
  constructor: (@name, @config, @rawData) ->
    @svg = HighchartsHelper.getNewPlayground(@format(@rawData))

  getSvg: () ->
    @svg
    
  format: (rawData) ->
    @data = {
      chart:
        type: 'column'
        forExport: true
        width: 600
        height: 400
      title:
        text: @name
      xAxis:
        type: 'datetime'
        min: rawData.resolvedTimeRange.startMillis
        max: rawData.resolvedTimeRange.endMillis
      yAxis:
        min: 0
      plotOptions:
        column:
          stacking: 'normal'
      series: @formatSeries(rawData)
    }

  #rawData is like raw.stackedbar.json
  #Function goal format it like highchart.stackedbar.js (series)
  formatSeries: (rawData) ->
    flatData = _.mapValues(rawData.records, 'map')

    seriesKeys = _(flatData)
      .mapValues(_.keys)
      .toArray()
      .flattenDeep()
      .uniq()
      .zipObject()
      .mapValues( (v, k) ->
        return k
      )
      .value()

    createSerie = (v, k) ->
      return {name : k, data:[]}

    xKeyFinder = _.partial(_.startsWith, _, '_')
    xKey = _(seriesKeys).chain().pickBy(xKeyFinder).values().first().value()
    series = _(seriesKeys).chain().omitBy(xKeyFinder).mapValues(createSerie).value()


    _.forEach(flatData, (record) ->
      _.forIn(record, (value, key, item) ->
        if (key isnt xKey)
          series[key].data.push({
            x: _.parseInt(item[xKey])
            y: _.parseInt(value)
          })
      )
    )
    return _.toArray(series);


module.exports = StackedBarChart
