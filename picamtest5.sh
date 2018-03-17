#!/bin/bash

# updated Mortfield 3/10/2018
# this version assumes a V1 camera 2592x1944 pixels
# add -r to to options for --raw
# add -v for verbose - great for testing


#created directory on my Pi called "picam" to put the images for testing. 
#feel free to alter

# options:  
# -q 100  ; jpg quality 100%
# -r      ; include RAW data
# -t      ; delay exposure 100ms (can be a smaller value)
# -awb auto ; sets white balance to auto. there are other settings
# -x      ;  allows embedding of EXIF data, like GPS. Need to tinker


OPTIONS=' -q 100 -r -t 100 -awb auto '
#OPTIONS2=' -x GPS.GPSAltitude=.......'  future use?

DATE2=$(date +'%Y%m%d_%H%M%S')
DATE3=$(date +"%Y-%m-%d_%H:%M:%S")
HOUR=$(date +"%R")
MYTIME=$(date +"%T")

# main capture.  filename is the date/time stamp
raspistill $OPTIONS  -o picam/raw/$DATE2.jpg


# uses imagemagick pkg for various conversions and inserting text.
#adding text to full frame jpg 2592 x 1944  converting to 800x600

# ***IMPORTANT***
# ****  after adding text to image ******
# **** saving here as a .jpg loses the RAW information
# ****  can do all this with a script after recovery too

MYFONTSIZE='30'
FUZMSG='Toronto_SpaceMakersCam1'

#  annotate after shrinking to 800x600. 
convert picam/raw/$DATE2.jpg  \
  -resize 800x600 \
  -pointsize $MYFONTSIZE -fill white -annotate  +480+575 \
  $DATE3 \
  -pointsize $MYFONTSIZE -fill white -annotate +30+575 \
  $FUZMSG  \
 picam/small/sm$DATE2.jpg








