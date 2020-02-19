#!/bin/bash

echo -e "Region dengan profit paling sedikit:"
A=$(awk '{
if ($13 != "Region")
	data[$13] += $21	
}
END{
	for (x in data){
		print data[x] " " x}
}' FPAT='([^,]*)|(".*")' soalmodul1.csv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 1)
echo "$A"
echo ""

echo -e "State dengan profit paling sedikit:"
B=$(awk '{
if ($11 != "State" && $13 == a)
	data[$11] += $21	
}
END{
	for (x in data){
		print data[x] " " x}
}' FPAT='([^,]*)|(".*")' a="$A" soalmodul1.csv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 2)
echo "$B"
echo ""


echo -e "10 Produk dengan profit paling sedikit:"
C=$(awk '{

split(b,y,"\n")

if ($17 != "Product Name" && ($11 == y[1] || $11 == y[2]))
	data[$17] += $21
}
END{
	for (x in data){
		print data[x] " " x}
}' FPAT='([^,]*)|(".*")' b="$B" soalmodul1.csv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 10)
echo "$C"
