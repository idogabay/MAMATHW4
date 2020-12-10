#!/bin/bash

wget -q https://www.ynetnews.com/category/3082
grep -o 'https://www.ynetnews.com/article/[0-9a-zA-Z]\{9\}[#"]' \
3082 > restext.txt
grep -o 'https://www.ynetnews.com/article/[0-9a-zA-Z]\{9\}' \
restext.txt > clnrestext.txt

sort -u -i clnrestext.txt >results.csv
wc -l  < results.csv 

#going line by line and counts the words we need.
while read line; do
	wget -q $line -O cur_line.txt
	bibi_count=$(grep -o "Netanyahu" cur_line.txt | wc -l)
	gantz_count=$(grep -o "Gantz" cur_line.txt | wc -l)
	if [[ ($bibi_count -ne 0)||($gantz_count -ne 0) ]]; then
		echo $line, Netanyahu, $bibi_count, Gantz, $gantz_count
	else
		echo $line, -
	fi
done < results.csv
