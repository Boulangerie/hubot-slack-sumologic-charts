_                 = require 'lodash'
moment            = require 'moment'
timecounterTpl    = require './svgTpl/timecounter.tpl'
SvgHelper         = require '../helpers/graphs/svgHelper'
unitMappings      = require '../constants/momentTimeUnitMapping'

class TimecounterChart
  constructor: (@name, @config, @rawData) ->
    @template = _.template(timecounterTpl)
    @variables = SvgHelper.getDimensions(@config)
    @svg = @template(_.merge(@variables, @format(@rawData)))

  getSvg: () ->
    @svg

  format: (rawData) ->
    field =  _.get(rawData, 'fields.0.name')
    value  = _.parseInt(_.get(rawData, "records.0.map.#{field}"))
    @extractUnit(value)

  extractUnit: (msTime) ->
    timeMap = {}
    time = moment.duration(msTime, 'ms')
    _.forEach(unitMappings, (mapping) ->
      formattedTime = time.get(mapping.unit)
      if formattedTime > 0
        timeMap = {value:formattedTime, metric: mapping.format}
      else
        return false
    )
    return timeMap


module.exports = TimecounterChart
