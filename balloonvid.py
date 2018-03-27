import time
import picamera
import datetime
import os.path
import RPi.GPIO as GPIO

# AstroHackers Pi Camera launch
# instantiating PiCamera

camera = picamera.PiCamera()

# camera setting
camera.video_stabilization = True
camera.exposure_mode = 'sports'
camera.awb_mode = 'auto'

#sleep time is in sec so need to record 6 files per hr.
#30 files of 10 min (600sec) each. 5 hrs total. 1.2GB used per video file
# High Resolution still images being taken at the end of each video period.
# some video will be lost due to transition time

i = 1

while (i <= 30):
    # Full HD video
    camera.resolution = (1920,1080)
    camera.start_recording('balloon{:%b-%d_%H:%M}.h264'.format(datetime.datetime.now()))                                             
    time.sleep(600)
    camera.stop_recording()
    print ('Captured video{}.h264'.format(i))
    #Highest resolution still capture every 10 minutes
    camera.resolution = (3280,2462)
    camera.capture ('Stillimage{:%b-%d_%H:%M}.jpg'.format(datetime.datetime.now()))
    print ('Captured Hiresimage{}.jpg'.format(i))
    i+= 1
