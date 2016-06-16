# Description
#   A hubot that puts back tables that have been flipped.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Simon Willcock[@<org>]

module.exports = (robot) ->
  robot.respond /hello/, (msg) ->
    msg.reply "hello!"

# (╯°□°）╯︵ ┻━┻
  robot.hear /\(╯°□°\）╯︵ ┻━┻/, ->
    msg.send "┬─┬ ノ( ゜-゜ノ)"
