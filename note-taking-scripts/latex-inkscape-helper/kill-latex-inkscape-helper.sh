#!/bin/sh

# Find and kill processes containing "inkscape" in their name
ps ax | grep inkscape | grep -v grep | awk '{print $1}' | xargs -r kill -9
ps ax | grep sxhkd | grep -v grep | awk '{print $1}' | xargs -r kill -9
