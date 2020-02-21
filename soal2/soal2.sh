#!/bin/bash

A=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 ; echo '')
B=$(echo $1 | tr -dc A-Za-z)
y=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
z=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
x=$((`date +%H`))
newB=$(echo $B | tr "${z:0:26}${y:0:26}" "${z:$x:26}${y:$x:26}")
echo $A>$newB.txt
