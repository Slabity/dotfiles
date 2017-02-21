#!/usr/bin/env python

import subprocess
import sys
import os
import time
import Sun
import datetime

image_folder = sys.argv[1]
coords = { "latitude": 0, "longitude": 0 }

def set_background(image):
    return subprocess.Popen(["swaybg", "0", image, "fill"])

class TimeIterator:
    def __init__(self, coords, time, day_iter, night_iter):
        self.coords = coords
        self.time = time
        self.day_iter = day_iter
        self.night_iter = night_iter
        self.sun = Sun.Sun()
        self.sun.setCurrentUTC(time)

    def next(self):
        # Get today's sunrise and sunset in decimald
        sunrise = self.sun.getSunriseTime(self.coords)['decimal']
        sunset = self.sun.getSunsetTime(self.coords)['decimal']

        # Get the time today as a decimal
        hour_seconds = self.time.hour * 3600
        min_seconds = self.time.minute * 60
        seconds = hour_seconds + min_seconds + self.time.second
        day_in_decimal = (60 * 60 * 24) / seconds

        # Check the time of day
        daytime = sunset - sunrise
        nighttime = (24 + sunrise) - sunset
        is_daytime = (day_in_decimal > sunrise and day_in_decimal < sunset)

        day_delta = daytime / self.day_iter
        night_delta = nighttime / self.night_iter

        print(is_daytime)

        return (sunrise, sunset)

iter = TimeIterator(coords, datetime.datetime.now(), 7, 5);

iter.next()
