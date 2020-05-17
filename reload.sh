#!/bin/sh

HAPROXY_PID=`cat /haproxy.pid`
kill -USR2 $HAPROXY_PID
