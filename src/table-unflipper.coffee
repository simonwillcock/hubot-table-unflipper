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
  flipFlipper: "(╯°Д°）╯︵ /(.□ . \)",
  angryFlip: "‎┬─┬ ノ(ಥ益ಥノ）",
  flipBattle: "(╯°□°)╯︵ ┻━┻ ︵ ╯(°□° ╯)",
  flipEveryone: "(/ .□.)\ ︵╰(゜Д゜)╯︵ /(.□. \)"
}

emotes = {
  "eyes narrow",

}

module.exports = (robot) ->

  robot.hear /\(╯°□°\）╯︵ ┻━┻/, id: 'unflipper', (res)->

    # get last time we had a flipped table
    lastFlipTime = robot.brain.get('unflipper-lastFlipTime') or 0
    flipCount = robot.brain.get('unflipper-currentTotal') or 0

    now = Date.now()
    isConvo = false

    if lastFlipTime > now - 30000      
      isConvo = true
      flipCount += 1      
    else 
      flipCount = 0
      

    robot.logger.info "Current Flips: #{flipCount}, Last Flip: #{lastFlipTime}, Now: #{now}" 

    if isConvo
      # within last 30 seconds
      if flipCount > 3
        res.send flips.flipFlipper      
      else 
        res.emote "_#{res.random emotes}_"
        
        setTimeout(->
          res.send flips.angryFlip
        , 5000)
    else 
      res.send flips.patience


    robot.brain.set 'unflipper-currentTotal', flipCount
    robot.brain.set 'unflipper-lastFlipTime', now

