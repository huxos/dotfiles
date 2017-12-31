-- Specify Spoons which will be loaded
hspoon_list = {
    "FnMate",
    "HCalendar",
    "KSheet",
    "SpeedMenu",
}
-- appM environment keybindings. Bundle `id` is prefered, but application `name` will be ok.
hsapp_list = {
    {key = 'c', id = 'com.google.Chrome'},
    {key = 'f', name = 'Finder'},
    {key = 'i', name = 'iTerm'},
    {key = 'l', name = 'Visual Studio Code'},
    {key = 'm', name = 'MacVim'},
    {key = 'v', id = 'com.apple.ActivityMonitor'},
    {key = 'y', id = 'com.apple.systempreferences'},
}

-- Modal supervisor keybinding, which can be used to temporarily disable ALL modal environments.
hsupervisor_keys = {{"cmd", "shift", "ctrl"}, "Q"}

-- Reload Hammerspoon configuration
hsreload_keys = {{"cmd", "shift", "ctrl"}, "R"}

-- Toggle help panel of this configuration.
hshelp_keys = {{"alt", "shift"}, "/"}

----------------------------------------------------------------------------------------------------
-- Those keybindings below could be disabled by setting to {"", ""} or {{}, ""}

-- Window hints keybinding: Focuse to any window you want
hswhints_keys = {"alt", "tab"}

-- appM environment keybinding: Application Launcher
hsappM_keys = {"alt", "A"}

-- countdownM environment keybinding: Visual countdown
hscountdM_keys = {"alt", "I"}

-- cheatsheetM environment keybinding: Cheatsheet copycat
hscheats_keys = {"alt", "S"}
