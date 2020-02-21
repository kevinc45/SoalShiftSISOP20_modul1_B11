#!/bin/bash

echo -e "Region dengan profit paling sedikit:"
A=$(awk -F '	' '{
if ($13 != "Region")
	column[$13] += $21	
}
END{
	for (x in column){
		print column[x] " " x}
}' Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 1)
echo "$A"
echo ""

echo -e "State dengan profit paling sedikit:"
B=$(awk -F '	' '{
if ($11 != "State" && $13 == a)
	column[$11] += $21	
}
END{
	for (x in column){
		print column[x] " " x}
}' a="$A" Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 2)
echo "$B"
echo ""


echo -e "10 Produk dengan profit paling sedikit:"
C=$(awk -F '	' '{

split(b,y,"\n")

if ($17 != "Product Name" && ($11 == y[1] || $11 == y[2]))
	column[$17] += $21
}
END{
	for (x in column){
		print column[x] " " x}
}' b="$B" Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 10)
echo "$C"
