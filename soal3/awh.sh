#!/bin/bash
cat wget.log | grep Location: > location.log

mkdir duplicate
mkdir kenangan

awk '{ i++
	print i ";" $2
}' location.log | awk -F ';' '{
counter[$2]++
if (counter[$2] > 1) {
 aws = "mv pdkt_kusuma_"$1 " duplicate/duplicate_"$1
}

else {
 aws = "mv pdkt_kusuma_"$1 " kenangan/kenangan_"$1
}
system(aws)

}'
ls *.log | awk '{
	aws  = "cp " $0 " $0 ".bak"
	system(aws)
}'

