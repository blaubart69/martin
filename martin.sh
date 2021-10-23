#!/bin/sh
  sed -e 's/;/\n/g' $1 \
| sed -e '/^$/d' \
| tr [:lower:] [:upper:] \
| awk '{ split($2,e,"+"); split(e[1],v,"."); printf "%s %04d.%04d.%04d%s\n", $1,v[1],v[2],v[3],(e[2]==""?"":"+"e[2])  }' \
| sort --reverse \
| sort  -k1,1 -t' ' --unique \
| awk '{ split($2,e,"+"); split(e[1],v,"."); printf "%s %d.%d.%d%s\n", $1,v[1],v[2],v[3],(e[2]==""?"":"+"e[2])  }'
