function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "ctrl"}, key, fn)
end

local positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.1, y=0.1, w=0.8, h=0.8},

  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},
  left70 = hs.layout.left70,

  right30 = hs.layout.right30,
  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper66 = {x=0, y=0, w=1, h=0.66},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper66Left50 = {x=0, y=0, w=0.5, h=0.66},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},
  upper66Right50 = {x=0.5, y=0, w=0.5, h=0.66},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower66 = {x=0, y=0.34, w=1, h=0.66},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower66Left50 = {x=0, y=0.34, w=0.5, h=0.66},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5},
  lower66Right50 = {x=0.5, y=0.34, w=0.5, h=0.66},

  chat = {x=0.5, y=0, w=0.35, h=0.5}
}

local grid = {
  {key="u", units={positions.upper50Left50, positions.upper66Left50}},
  {key="k", units={positions.upper50, positions.upper66}},
  {key="i", units={positions.upper50Right50, positions.upper66Right50}},

  {key="o", units={positions.maximized, positions.centered}},

  {key="h", units={positions.left50, positions.left66, positions.left34}},
  {key="g", units={positions.centered, positions.maximized}},
  {key="l", units={positions.right50, positions.right66, positions.right34}},

  {key="n", units={positions.lower50Left50, positions.lower66Left50}},
  {key="j", units={positions.lower50, positions.lower66}},
  {key="m", units={positions.lower50Right50, positions.lower66Right50}}
}

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = screen:fromUnitRect(unit)
      -- sometimes the screen reports slightly larger than the usable space
      -- on iMac retina it the size might differ up to 5 pixels so simple equals won't work
      -- we check that the centerd and left edge are close enough
      return windowGeo:distance(geo) < 10 and math.abs(windowGeo.x - geo.x) < 1
    end)
    if index == #units then index = 0 end

    currentLayout = null
    window:moveToUnit(units[index + 1])
  end)
end)
