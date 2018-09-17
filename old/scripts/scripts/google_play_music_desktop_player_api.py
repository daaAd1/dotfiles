#!/usr/bin/env python3
# Uses Google Play Desktop Player [Unofficial]'s API for now playing.

import json
from os.path import expanduser

GPMDP_API = expanduser('~') + '/.config/Google Play Music Desktop Player/json_store/playback.json'
button = ""

def main():
    with open(GPMDP_API, 'r') as f:
        data = json.load(f)
        if data['playing']:
            print('{button} {title} -- {artist} |'.format(button=button, title=data['song']['title'], artist=data['song']['artist']));
        else:
            print('Not Playing')

if __name__ == '__main__':
    main()

def button_click():
	