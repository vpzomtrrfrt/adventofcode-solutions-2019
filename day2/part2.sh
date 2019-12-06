#!/bin/bash

TARGET=19690720

IFS=, read -ra orig_data

for noun in $(seq 0 $((${#orig_data[@]} - 1))); do
	for verb in $(seq 0 $((${#orig_data[@]} - 1))); do
		pos=0
		data=("${orig_data[@]}")

		data[1]=$noun
		data[2]=$verb

		while true; do
			current_op=${data[$pos]}

			case $current_op in
				99)
					break
					;;
				1)
					in1pos=${data[$pos+1]}
					in2pos=${data[$pos+2]}
					outpos=${data[$pos+3]}

					in1=${data[$in1pos]}
					in2=${data[$in2pos]}

					result=$(($in1+$in2))

					data[$outpos]=$result
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

		if [ ${data[0]} -eq $TARGET ]; then
			echo $((100 * $noun + $verb))
			exit
		fi
	done
done
