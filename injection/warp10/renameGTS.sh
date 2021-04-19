#!/bin/bash
cd gts
for i in *.gts ; do 
  mv $i $(echo $i | sed -e 's/m//g' -e 's/v/_/g' -e 's/A/_A/g' -e 's/B/_B/g' -e 's/C/_C/g')
done
cd ..
