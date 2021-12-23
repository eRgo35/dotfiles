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

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/custom"
theme.wallpaper                                 = "/usr/share/backgrounds/desktopbg.png"
theme.font                                      = "SauceCodePro Nerd Font Mono 9"
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
    "date +'%a %d %I:%M %P'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "SauceCodePro Nerd Font Mono 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- MPD
local musicplr = awful.util.terminal .. " -title Music -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ "Mod4" }, 1, function () awful.spawn(musicplr) end),
    awful.button({ }, 1, function ()
        os.execute("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        os.execute("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        os.execute("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(theme.widget_music)
        end

        widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰍛")) .. markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰻠")) .. markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰔏")) .. markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- fs
-- commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "SauceCodePro Nerd Font Mono 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font_icon, markup("#b4b4b4", " 󰋊")) .. markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
    end
})

-- Weather
theme.weather = lain.widget.weather({
  APPID = weather.weatherAPI,
  city_id = weather.weatherCity,
  notification_preset = { font = "SauceCodePro Nerd Font Mono 10" },
  settings = function()
      units = math.floor(weather_now["main"]["temp"])
      widget:set_markup(" " .. markup.font(theme.font, " " .. units .. "°C") .. " ")
  end
})

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
theme.volume.widget:buttons(awful.util.table.join(
  awful.button({}, 1, function() -- left click
      awful.spawn(string.format("%s set %s toggle", "amixer", "Master"))
      theme.volume.update()
  end),
  awful.button({}, 2, function() -- middle click
      os.execute(string.format("%s set %s 100%%", "amixer", "Master"))
      theme.volume.update()
  end),
  awful.button({}, 3, function() -- right click
      os.execute(string.format("%s -e alsamixer", terminal))
      theme.volume.update()
  end),
  awful.button({}, 4, function() -- scroll up
      os.execute(string.format("%s set %s 1%%+", "amixer", "Master"))
      theme.volume.update()
  end),
  awful.button({}, 5, function() -- scroll down
      os.execute(string.format("%s set %s 1%%-", "amixer", "Master"))
      theme.volume.update()
  end)
))

-- Net
local net = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local wired0 = ""
        local wired1 = ""
        local wifi0 = ""

        local eth0 = net_now.devices.enp0s31f6
        if eth0 then
            if eth0.ethernet then
                wired0 = markup.font(theme.font_icon, markup("#b4b4b4", "󰈀") .. markup.font(theme.font, " " .. eth0.state .. " ")) --"IP: " .. os.execute(string.format("ip -4 -o addr show %s | awk '{print $4}'", eth0))
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
local spr     = wibox.widget.textbox(' ')
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
            wibox.widget.systray(),
            -- keyboardlayout,
            spr,
            arrl_ld,
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(theme.weather.icon, theme.bg_focus),
            wibox.container.background(theme.weather.widget, theme.bg_focus),
            arrl_dl,
            wibox.container.background(theme.volume.widget, theme.bg_normal),
            arrl_ld,
            wibox.container.background(mem.widget, theme.bg_focus),
            arrl_dl,
            wibox.container.background(cpu.widget, theme.bg_normal),
            arrl_ld,
            wibox.container.background(theme.fs.widget, theme.bg_focus),
            arrl_dl,
            bat.widget,
            temp.widget,
            arrl_ld,
            wibox.container.background(net.widget, theme.bg_focus),
            arrl_dl,
            clock,
            spr,
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
end

return theme
