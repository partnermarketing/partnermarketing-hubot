# Description:
#   An HTTP Listener for notifications on autobot release pushes
#
# Dependencies:
#   "url": ""
#   "querystring": ""
#   
#
# Configuration:
#   Just put this url <HUBOT_URL>:<PORT>/hubot/autobot-release?room=<room> into Autobot
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/autobot-release?room=<room>[&type=<type]
#
# Authors:
#   Jon Busby
#
# Additional:
# This is a modified version of the github script available here : 
# https://github.com/github/hubot-scripts/blob/master/src/scripts/github-commits.coffee


url = require('url')
querystring = require('querystring')

module.exports = (robot) ->

  robot.router.post "/hubot/autobot-release", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)

    res.end

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type
    console.log "#{req.body}"

    try
      #payload = JSON.parse req.body
      payload = req.body
      if payload.release
        robot.send user, "RELEASE : v#{payload.release.version} of #{payload.release.name} released on #{payload.release.branch} by #{payload.release.author.name}"

    catch error
      console.log "autobot-release error: #{error}. Payload: #{req.body.payload}"

