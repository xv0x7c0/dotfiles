#!/bin/sh

SLEEP_SEC=2

print_date(){
  FORMAT="%a %d %b [%W] %H:%M"
  DATE=`date "+${FORMAT}"`
  echo -n "${DATE}"
}

print_volume(){
  `ponymix --output is-muted`
  if [[ $? -eq 0 ]];then
    VOLUME="M"
  else
    VOLUME="`ponymix get-volume`"
  fi
  echo -ne "${VOLUME}"
}

print_song_status(){
  `mpc | grep -q paused`
  if [[ $? -eq 0 ]];then
    SONG_STATUS="="
  else
    SONG_STATUS=">"
  fi
  echo -ne "${SONG_STATUS}"
}

print_song(){
  SONG=`mpc current -f '[[[[%artist%] - "%title%]]|[%file%]]"'`
  echo -ne "${SONG}"
}

while :;do
  DATE=`print_date`
  VOLUME=`print_volume`
  SONG=`print_song`
  SONG_STATUS=`print_song_status`
  echo -e "$DATE :: [$VOLUME] [$SONG_STATUS] $SONG"
  sleep $SLEEP_SEC
done
