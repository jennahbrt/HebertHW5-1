#!/bin/bash
# An edit of Molloy's orginal code by Jenna Hebert. This script takes three  input 
# arguments, a command, blink and an integer to run a number of times 
# A small Bash script to set up User LED3 to be turned on or off from 
#  Linux console. Written by Derek Molloy (derekmolloy.ie) for the 
#  book Exploring BeagleBone.

LED3_PATH=/sys/class/leds/beaglebone:green:usr3

# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}

echo "Starting the LED Bash Script"
if [ $# -eq 0 ]; then
  echo "There are no arguments, blink or statuts. Usage is:"
  echo -e "   on, off, flash, blink or status  \n e.g. bashLED on "
  echo -e " \n if blink is chosen, should be followed by the number of times it should blink"
  exit 2
fi

command=$1
n=$2

echo "The LED Command that was passed is: $command"
if [ "$command" == "on" ]; then
  echo "Turning the LED on"
  removeTrigger
  echo "1" >> "$LED3_PATH/brightness"
elif [ "$command" == "off" ]; then
  echo "Turning the LED off"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"
elif [ "$command" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
  echo "100" >> "$LED3_PATH/delay_off"
  echo "100" >> "$LED3_PATH/delay_on"
elif [ "$command" == "status" ]; then
  cat "$LED3_PATH/trigger";
elif [ "$command" == "blink" ]; then
  if [ $n -eq 0 ]; then
   echo "When using blink, pas the number of times to blink"
   exit 3 
  fi
echo "Blinking the LED $n times"
 until [ $n -le 0 ]
  do
   removeTrigger
   echo "1" >> "$LED3_PATH/brightness"
   sleep 1 
   echo "0" >> "$LED3_PATH/brightness"
   sleep 1
   ((n--))
  done



fi
echo "End of the LED Bash Script"
