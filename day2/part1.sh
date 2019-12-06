#!/bin/bash

IFS=, read -ra data

pos=0

data[1]=12
data[2]=2

while true; do
	current_op=${data[$pos]}

	case $current_op in
		99)
			break
			;;
		1)
			in1=${data[${data[$pos+1]}]}
			in2=${data[${data[$pos+2]}]}

			result=$(($in1+$in2))

			data[${data[$pos+3]}]=$result
			;;
		2)
			in1=${data[${data[$pos+1]}]}
			in2=${data[${data[$pos+2]}]}

			result=$(($in1*$in2))

			data[${data[$pos+3]}]=$result
			;;
	esac
	pos=$pos+4
done

echo ${data[0]}
