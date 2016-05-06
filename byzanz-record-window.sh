#!/bin/bash


if [ $# -gt 0 ]; then
	DELAY="$1"
else
	DELAY=10
fi

# Duration and output file
if [ $# -gt 0 ]; then
    D="--duration=$2 $3"
else
    echo Default recording duration 10s to /tmp/recorded.gif
    D="--duration=10 /tmp/recorded.gif"
fi

# Ask for selecting the window
XWININFO=$(xwininfo)
read X <<< $(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
read Y <<< $(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
read W <<< $(awk -F: '/Width/{print $2}' <<< "$XWININFO")
read H <<< $(awk -F: '/Height/{print $2}' <<< "$XWININFO")

echo Delaying $DELAY seconds. After that, byzanz will start recording
for (( i=$DELAY; i>0; --i )) ; do
    echo $i
    sleep 1
done

byzanz-record --verbose --delay=0 --x=$X --y=$Y --width=$W --height=$H $D

# Show notication upon recording completion
notify-send "Byzanz recording" "
Recording completed" -t 2000
