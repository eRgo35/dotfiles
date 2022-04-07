--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local weather = require("themes/custom/config")

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/custom"
theme.wallpaper                                 = "/usr/share/backgrounds/wallpaper.jpg"
theme.font                                      = "Roboto Condensed Regular 9"
theme.font_icon                                 = "materialdesignicons-webfont 9"
theme.fg_normal                                 = "#ECEFF4"
theme.fg_focus                                  = "#81A1C1"
theme.fg_urgent                                 = "#BF616A"
theme.bg_normal                                 = "#1d2129"
theme.bg_focus                                  = "#2E3440"
theme.bg_urgent                                 = "#1d2129"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#00000000"
theme.border_focus                              = "#00000000"
theme.border_marked                             = "#00000000"
theme.tasklist_bg_focus                         = "#1d2129"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
-- old icons
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %b %d, %I:%M %P'", 1,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

clock:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then theme.cal.toggle() end  
  end)

theme.cal = calendar_widget({
  theme = 'nord',
  placement = 'top_right',
  start_sunday = true,
  radius = 8
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰍛")) .. markup.font(theme.font, " " .. math.floor((mem_now.used)/1000) .. " GB"))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰻠")) .. markup.font(theme.font, " " .. cpu_now.usage .. "%"))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        local f = io.popen("sensors | grep 'Tctl' | grep -o '[0-9][0-9].[0-9]°C '")
        local output = f:read("*all")
        f:close()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰔏")) .. markup.font(theme.font, " " .. output .. coretemp_now .. "°C "))
    end
})

theme.fs = fs_widget({ mounts = { '/', '/mnt/data' } })

-- Battery
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status == "Full" then
            widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁹")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
        elseif bat_now.status == "Discharging" then
            if bat_now.perc and tonumber(bat_now.perc) < 10 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂃")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 20 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁺")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 30 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁻")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 40 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁼")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 50 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁽")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 60 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁾")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 70 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁿")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 80 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂀")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 90 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂁")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) < 100 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂂")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) == 100 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰁹")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            else
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂌")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            end
        elseif bat_now.status == "Charging" then
            if bat_now.perc and tonumber(bat_now.perc) < 10 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰢟")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 20 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰢜")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 30 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂆")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 40 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂇")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 50 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂈")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 60 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰢝")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 70 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂉")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 80 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰢞")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) <= 90 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂊")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) < 100 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂋")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif bat_now.perc and tonumber(bat_now.perc) == 100 then
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂅")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            else
                widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰂏")) .. markup.font(theme.font, " " .. bat_now.perc .. "% "))
            end
        elseif bat_now.status == "N/A" then
            widget:set_markup(markup.font(theme.font, ""))
        end
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    timeout = 0.5,
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰖁")) .. markup.font(theme.font, " "))
        elseif tonumber(volume_now.level) == 0 then
            widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰕿")) .. markup.font(theme.font, " " .. volume_now.level .. "% "))
        elseif tonumber(volume_now.level) <= 50 then
            widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰖀")) .. markup.font(theme.font, " " .. volume_now.level .. "% "))
        else
            widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰕾")) .. markup.font(theme.font, " " .. volume_now.level .. "% "))
        end
    end
})

-- Net
local net = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local wired0 = ""
        local wired1 = ""
        local wifi0 = ""

        local eth0 = net_now.devices.enp34s0
        if eth0 then
            if eth0.ethernet then
                wired0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰈀") .. markup.font(theme.font, " " .. eth0.state .. " ")) --"IP: " .. os.execute(string.format("ip -4 -o addr show %s | awk '{print $4}'", eth0))
            end
        end

        local eth1 = net_now.devices.enp0s25
        if eth1 then
            if eth1.ethernet then
                wired1 = markup.font(theme.font_icon, markup("#b4b4b4", "󰈀") .. markup.font(theme.font, " " .. eth1.state .. " ")) --"IP: " .. os.execute(string.format("ip -4 -o addr show %s | awk '{print $4}'", eth0))
            end
        end

        local wlan0 = net_now.devices.wlp3s0
        if wlan0 then
            if wlan0.wifi then
                local signal = wlan0.signal
                if signal < -83 then
                    wifi0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰤟 ")) .. markup.font(theme.font, wlan0.state .. " ")
                elseif signal < -70 then
                    wifi0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰤢 ")) .. markup.font(theme.font, wlan0.state .. " ")
                elseif signal < -53 then
                    wifi0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰤥 ")) .. markup.font(theme.font, wlan0.state .. " ")
                elseif signal >= -53 then
                    wifi0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰤨 ")) .. markup.font(theme.font, wlan0.state .. " ")
                end
            else
              wifi0 = markup.font(theme.font_icon, markup("#b4b4b4", " 󰤭 ") .. markup.font(theme.font, " " .. wlan0.state .. " "))
            end
        end

        widget:set_markup(wired0 .. wired1 .. wifi0)
    end
}


-- Separators
local spr     = wibox.widget.textbox('  ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            keyboardlayout,
            spr,
            s.systray,
            spr,
            spotify_widget({ dim_when_paused = true, play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg', pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg', show_tooltip = false }),
            spr,
            cpu_widget(),
            spr,
            mem.widget,
            spr,
            weather_widget({ api_key=weather.weatherAPI, coordinates=weather.weatherCoords }),
            spr,
            volume_widget({ mixer_cmd = 'easyeffects' }),
            spr,
            clock,
            spr,
            s.mylayoutbox,
        },
    }
end

return theme
