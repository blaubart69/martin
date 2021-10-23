#!/bin/sh
  sed 's/;/\n/g;/^$/d' $1 \
| sed '/^$/d' \
| tr [:lower:] [:upper:] \
| awk '{ split($2,e,"+");   \
         split(e[1],v,"."); \
         printf "%s %04d.%04d.%04d%s %s\n", $1,v[1],v[2],v[3],(e[2]==""?"":"+"e[2]),$2 }' \
| sort --reverse \
| sort  -k1,1 -t' ' --unique \
| cut -d" " -f1,3
