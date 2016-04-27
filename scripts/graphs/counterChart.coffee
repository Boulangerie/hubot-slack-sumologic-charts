_                 = require 'lodash'
numeral           = require 'numeral'
counterTpl        = require './svgTpl/counter.tpl'
SvgHelper         = require '../helpers/graphs/svgHelper'

class CounterChart
  constructor: (@name, @config, @rawData) ->
    @template = _.template(counterTpl)
    @variables = SvgHelper.getDimensions(@config)
    @svg = @template(_.merge(@variables, @format(@rawData)))

  getSvg: () ->
    @svg

  format: (rawData) ->
    fieldName =  @extractFieldName(_.get(rawData, 'fields', []))
    value  = _.parseInt(_.get(rawData, "records.0.map.#{fieldName}"))
    numberFormatted = numeral(value).format('0a').match(/([0-9]*)([a-zA-Z])?$/)
    if _.isUndefined(numberFormatted[2])
      numberFormatted[2] = ''
    return {value : numberFormatted[1], metric: numberFormatted[2]}

  extractFieldName: (fields) ->
    allowedFieldTypes = ['int', 'double']
    field = _.filter(fields, (item) ->
      _.includes(allowedFieldTypes, item.fieldType)
    )
    if field.length is 1
      return _.first(field).name
    else
      throw "Counter Graph : Don't find an eligible field, in JSON after #{JSON.stringify(fields, null, 4)}"

module.exports = CounterChart
