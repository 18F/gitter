#!/bin/bash

if [[ ! -d /tmp/fakes3_root ]]; then
  mkdir /tmp/fakes3_root || return 1
fi

case $1 in
  start)
    fakes3 -r /tmp/fakes3_root -p 4567 &>/dev/null &
    echo $! > /tmp/fakes3.pid
    ;;
  stop)
    kill -9 `cat /tmp/fakes3.pid`
    ;;
  restart)
    $0 stop
    sleep 3
    $0 start
    ;;
esac