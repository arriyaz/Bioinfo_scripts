#!/bin/bash

read -e -p "Insert your file name: " FILE 

LINE_NUM=1
while read LINE
do
	echo "${LINE_NUM} :  ${LINE}"
	((LINE_NUM++))
done < $FILE

