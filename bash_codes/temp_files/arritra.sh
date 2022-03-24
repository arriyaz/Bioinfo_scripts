#!/bin/bash

while true
do
 cowsay "Arittra is single!" &\
play -q contents/arittra-is-single.mp3
sleep .5
echo
xcowsay "Ha ha ha!!" &\
play -q contents/ha-ha-ha.mp3
done


