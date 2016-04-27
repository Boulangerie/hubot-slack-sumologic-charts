class HubotTeleporter
  constructor: () ->

  enter: (@robot) ->
    @robot

  out: () ->
    @robot

module.exports = new HubotTeleporter()
