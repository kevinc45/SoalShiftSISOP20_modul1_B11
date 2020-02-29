#!/bin/bash

B=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
y=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
z=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
newB=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${z:$B:26}${y:$B:26} ${z:0:26}${y:0:26})
cp $1 $newB".txt"
