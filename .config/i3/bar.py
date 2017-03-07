#!/usr/bin/python

import i3ipc
import math
import datetime
import netifaces
import psutil
import time
import sys

# Define the colors here
background = '#0f0808'
foreground = '#E0BFBF'
color0 = '#000000'
color1 = '#A80000'
color2 = '#802F3C'
color3 = '#CC1818'
color4 = '#6A3D37'
color5 = '#730015'
color6 = '#555555'
color7 = '#B3B3B3'
color8 = '#4D0606'
color9 = '#FF1D04'
color10 = '#B32626'
color11 = '#FF3700'
color12 = '#F07B6C'
color13 = '#CF3030'
color14 = '#CCCCCC'
color15 = '#FFFFFF'

# Define the characters here
rArrowFull = u'\uE0B0'
rArrowLine = u'\uE0B1'
lArrowFull = u'\uE0B2'
lArrowLine = u'\uE0B3'

wifiConnected = u'\uE02D'
clock = u'\uE015'
memory = u'\uE020'
drive = u'\uE02A'
batteryFull = u'\uE033'
ethernetConnected = u'\uE042'

def getTime():
    return time.strftime("%H:%M:%S", time.localtime())

def getMemory():
    totalMem = psutil.virtual_memory().total
    percMem = psutil.virtual_memory().percent
    return str(math.floor((totalMem * percMem / 100000000))) + "M"

def getIP(interface, addressFamily):
    try:
        return netifaces.ifaddresses(interface)[addressFamily][0]['addr']
    except KeyError:
        return 'Disconnected'

def getDiskUsage(directory):
    return str(psutil.disk_usage(directory).percent) + "%"

def getBatteryLife(battery):
    battery.seek(0)
    return battery.read()[:-1] + '%'

battery0 = open('/sys/class/power_supply/BAT0/capacity', 'r')
battery1 = open('/sys/class/power_supply/BAT1/capacity', 'r')

# Define apps here. Each app must return in the following format:
# (icon, text, foreground, background)
memApp = lambda: (memory, getMemory(), foreground, color1)
wifiApp = lambda: (wifiConnected, getIP('wlp3s0', 2), foreground, color8)
ethApp = lambda: (ethernetConnected, getIP('enp0s25', 0), foreground, color1)
rootApp = lambda: (drive, getDiskUsage('/'), foreground, color8)
homeApp = lambda: (drive, getDiskUsage('/home'), foreground, color1)
bat0App = lambda: (batteryFull, getBatteryLife(battery0), foreground, color8)
bat1App = lambda: (batteryFull, getBatteryLife(battery1), foreground, color1)
clockApp = lambda: (clock, getTime(), foreground, color8)

appList = [memApp, wifiApp, ethApp, rootApp, homeApp, bat0App, bat1App, clockApp]

def formatApp(prevBack, app):
    ret = ""
    if prevBack == app[3]:
        ret += "%{F" + app[2] + "}" + str(lArrowLine)
    else:
        ret += "%{F" + app[3] + "}" + str(lArrowFull) + "%{F" + app[2] + "}%{B" + app[3] + "}"
    ret += " " + app[0] + " " + app[1] + " "
    return ret


# Print out the apps in the format required for lemonbar
def formatApps(apps):
    ret = formatApp(background, apps[0])

    # Append the icon and text for the first app
    for (p, c) in zip(apps, apps[1:]):
        ret += formatApp(p[3], c)

    # Set the foreground and background colors back
    ret += "%{F" + foreground + "}%{B" + background + "}"
    return ret


# Define the different types of apps here.
class WorkspaceApp:
    def __init__(self, output):
        WorkspaceApp.connection = i3ipc.Connection()
        self.output = output
    def getInfo(self):
        return filter(lambda w: w.output == self.output, WorkspaceApp.connection.get_workspaces())
    def getColors(self):
        return (background, foreground)

# Format the workspaces app
def printWorkspaces(app):
    ws = list(app.getInfo())
    ret = ""
    for (c, n) in zip(ws, ws[1:]):
        cBack = color8
        cFore = foreground
        nBack = color8
        # Get the current workspace's colors
        if c.visible:
            cBack = color1
        elif c.urgent:
            cBack = color11
        # Get the next workspace's colors
        if n.visible:
            nBack = color1
        elif n.urgent:
            nBack = color11
        # Record the status
        ret += "%{B" + cBack + "}%{F" + cFore + "}" + "%{A:i3-msg workspace " + c.name + " &:} " + c.name + " %{A}"

        if cBack == nBack:
            ret += str(rArrowLine)
        else:
            ret += "%{B" + nBack + "}%{F" + cBack + "}" + str(rArrowFull)

    # Print out the final workspace
    last = ws[-1]
    back = color8
    fore = foreground
    if last.visible:
        back = color1
    elif last.urgent:
        back = color11
    ret += "%{B" + back + "}%{F" + fore + "}" + "%{A:i3-msg workspace " + last.name + " &:} " + last.name + " %{A}"

    if back == background:
        ret += str(rArrowLine)
    else:
        ret += "%{B" + background + "}%{F" + back + "}" + str(rArrowFull)

    return ret

# Initialize the apps here
wseDP1 = WorkspaceApp('eDP1')

while True:
    executedApps = [(app)() for app in appList]
    workspaces = "%{l}" + printWorkspaces(wseDP1)
    rightSide = "%{r}" + formatApps(executedApps)
    print(workspaces +  rightSide)
    time.sleep(0.05)
    sys.stdout.flush()

