# Description
#   A hubot that cleans up after angry people
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   (╯°□°）╯︵ ┻━┻ - Unflips a flipped table
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Simon Willcock[@truss]

delay = (ms, func) -> setTimeout func, ms

flips = {
  flip: "(╯°□°)╯︵ ┻━┻",
  patience: "┬─┬ ノ( ゜-゜ノ)",
  happyUnflip: "┬─┬ ノ( '□'ノ)",
  flipFlipper: "(╯°Д°）╯︵ /(.□ . \)",
  angryFlip: "‎┬─┬ ノ(ಥ益ಥノ）",
  flipBattle: "(╯°□°)╯︵ ┻━┻ ︵ ╯(°□° ╯)",
  flipEveryone: "(/ .□.)\ ︵╰(゜Д゜)╯︵ /(.□. \)",
  magicFlip: "(/¯◡ ‿ ◡)/¯ ~ ┻━┻",
  jediFlip: "(._.) ~ ︵ ┻━┻"
}

notEvenMad = [
  "http://neeshcast.com/wp-content/uploads/2014/07/Anchorman-Im-not-even-mad.png"
]

emotes = [
  "eyes narrow",
  "eyes twitch",
  "clenches fist"
]

tableReplacedResponses = [
  "Thanks mate!",
  "https://media.makeameme.org/created/They-took-our-gggfx8.jpg"
]
module.exports = (robot) ->

  robot.hear /((?:ʕノ•ᴥ•ʔノ|\(\/¯◡ ‿ ◡\)\/¯ ~|\(._.\) ~|\(╯'□'\)╯|\(╯°□°）╯|\(ノ ゜Д゜\)ノ|\‎\(ﾉಥ益ಥ）ﾉ\﻿)\s?︵? ┻━┻)/, id: 'unflipper', (res)->

    # get last time we had a flipped table
    lastFlipTime = robot.brain.get('unflipper-lastFlipTime') or 0
    flipCount = robot.brain.get('unflipper-currentTotal') or 0

    # get flip emote
    flipType = res.match[1]

    now = Date.now()
    isConvo = false

    isCleverFlip = flipType == flips.jediFlip or flipType == flips.magicFlip

    if lastFlipTime > now - 30000
      isConvo = true
      if not isCleverFlip
        flipCount += 1
    else 
      flipCount = 0
    
    
    
    robot.logger.info "Current Flips: #{flipCount}, Last Flip: #{lastFlipTime}, Now: #{now}" 


    if isCleverFlip
      res.send "..what the... you didn't even use your hands!?"
      res.send res.random notEvenMad
      res.send flips.happyUnflip
    else if isConvo
      # within last 30 seconds
      if flipCount >= 8
        res.emote "_quiet sobbing_"
      else if flipCount == 7
        res.send "No!"
      else if flipCount == 6
        res.send "You guys are mean :("
      else if flipCount == 5
        setTimeout(->
          res.send flips.flipFlipper
        , 5000)
      else if flipCount >= 4
        res.send flips.angryFlip
      else if flipCount >= 2
        res.emote "_#{res.random emotes}_"    
        setTimeout(->    
          res.send flips.patience
        , 2000)
      else 
        res.send flips.patience

    else 
      res.send flips.patience


    robot.brain.set 'unflipper-currentTotal', flipCount
    robot.brain.set 'unflipper-lastFlipTime', now

  robot.hear /(┬─┬ ノ\( ゜-゜ノ\)|┬─┬ ノ\( '□'ノ\))/, (res) ->
    res.send res.random tableReplacedResponses

  #robot.respond /put that back (pl(?:s|ease))?/

