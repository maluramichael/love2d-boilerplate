return {
  graphics = {
    filter = {
      -- FilterModes: linear (blurry) / nearest (blocky)
      -- Default filter used when scaling down
      down = "nearest",
      -- Default filter used when scaling up
      up = "nearest",
      -- Amount of anisotropic filter performed
      anisotropy = 0
    }
  },
  debug = {
    key = "`",
    stats = {
      font = nil, -- set after fonts are created
      fontSize = 32,
      lineHeight = 40,
      foreground = {255, 255, 255, 225},
      shadow = {0, 0, 0, 225},
      shadowOffset = {x = 3, y = 3},
      position = {x = 8, y = 6},
      kilobytes = false
    },
    -- Error screen config
    error = {
      font = nil, -- set after fonts are created
      fontSize = 16,
      background = {26, 79, 126},
      foreground = {255, 255, 255},
      shadow = {0, 0, 0, 225},
      shadowOffset = {x = 1, y = 1},
      position = {x = 70, y = 70}
    },
    lovebird = {
      port = 9001,
      wrapPrint = true,
      echoInput = true,
      updateInterval = 0.2,
      maxLines = 200,
      openInBrowser = false
    }
  }
}
