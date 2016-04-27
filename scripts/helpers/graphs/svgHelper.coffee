_         = require 'lodash'

class SvgHelper
  constructor: () ->

  #If the svg is less than 400px, phamtomjs or svgTopng seems to not
  #allow this value and fallback with 400x300 dimensions
  getDimensions: (chartData) ->
    width   = _.get(chartData, 'width', 400)
    height  = _.get(chartData, 'height', 400)
    return {
      width: if width <= 400 then 400 else width
      height: if height <= 400 then 400 else height
    }

module.exports = new SvgHelper()
