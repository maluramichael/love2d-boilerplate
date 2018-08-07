-- Third party
gameState = require "thirdparty.hump.gamestate"
lume = require "thirdparty.lume.lume"
cargo = require "thirdparty.cargo.cargo"

RELEASE = false
DEBUG = not RELEASE

config = require "settings"
fonts = require "fonts"
helper = require "helper"

assetLoadTime = love.timer.getTime()
assets = cargo.init('assets')
assetLoadTime = (love.timer.getTime() - assetLoadTime)

config.debug.stats.font = fonts.monospace
config.debug.error.font = fonts.monospace

states = require "scenes.states"

if DEBUG then
  Lovebird = require "thirdparty.lovebird.lovebird"
  Lovebird.port = config.debug.lovebird.port
  Lovebird.wrapprint = config.debug.lovebird.wrapPrint
  Lovebird.echoinput = config.debug.lovebird.echoInput
  Lovebird.updateinterval = config.debug.lovebird.updateInterval
  Lovebird.maxlines = config.debug.lovebird.maxLines
  print("Running Lovebird on localhost:" .. Lovebird.port)
  if config.debug.lovebird.openInBrowser then
    love.system.openURL("http://localhost:" .. Lovebird.port)
  end
end
