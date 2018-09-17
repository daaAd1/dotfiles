#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-
# vim:ts=2:sw=2:expandtab
 
import os
from PIL import Image
 
def screenshot():
  os.system('import -window root /tmp/.i3lock.png')
 
def obscure_image(image):
  """ Obscures the given image. """
  size = image.size
  pixel_size = 9
 
  image = image.resize((size[0] / pixel_size, size[1] / pixel_size), Image.NEAREST)
  image = image.resize((size[0], size[1]), Image.NEAREST)
 
  return image
 
def obscure():
  image = Image.open('/tmp/.i3lock.png')
  size = image.size
  pixel_size = 9
 
  image = image.resize((size[0] / pixel_size, size[1] / pixel_size), Image.NEAREST)
  image = image.resize((size[0], size[1]), Image.NEAREST)
 
  image.save('/tmp/.i3lock.png')
 
def lock_screen():
  os.system('i3lock -n -i /tmp/.i3lock.png \
    --insidecolor=373445ff --ringcolor=ffffffff --line-uses-inside \
    --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
    --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+86:y+1003" \
    --radius=15 --veriftext="" --wrongtext=""')
 
if __name__ == '__main__':
  screenshot()
  obscure()
  lock_screen()
