#!/bin/bash
# Torque CSV log files are able to be imported into Goole Maps, but 
# Google Maps only allows 2000 data-points per CSV file
MAX_LINES=2000
# Find the Torque log files in this folder and segments them into smaller parts
for CURRENT_FILE in `find -name trackLog\*.csv`; do 
	echo Segmenting $CURRENT_FILE
	# Number of lines in current log file
	FILE_LINES=$(wc -l $CURRENT_FILE | cut -f1 -d' ')

	if [ $FILE_LINES -gt $MAX_LINES ]; then 
		# More lines than allowed to be import so split file with head and tail since split doesn't allow for CSV header line
		echo Splitting up $CURRENT_FILE which has lines $FILE_LINES;
		# Partial filename to allow sequence tagging
		FILE_BASE=$(echo ${CURRENT_FILE/.csv/})  
		CHUNK_END=0  # Reset to start at top of file
		for PART in $(seq 1 $((FILE_LINES/MAX_LINES+1))); do
			# Number of files determinde by integer division of Lines/Max +1
			CHUNK_END=$((CHUNK_END+MAX_LINES))
			# the partial file fragment
			PARTIAL_FILE="$FILE_BASE-$PART.csv"
			if [ $CHUNK_END -gt $FILE_LINES ]; then
				# Last file only tails the Lines Modulus MAX_LINES else adds redundant line
				PARTIAL_LINES=$((FILE_LINES%MAX_LINES))
				# Add the CSV header line to the last partial file fragment
				head -n1 $CURRENT_FILE  > $PARTIAL_FILE
			else
				PARTIAL_LINES=$MAX_LINES;
				if [ $CHUNK_END -gt $MAX_LINES ]; then
					# Add the CSV header line to the partial file fragment after the first file
					head -n1 $CURRENT_FILE  > $PARTIAL_FILE
				fi
			fi
			# Create the segqment of the Torque file 
			echo -e "\t Segment $PART put into $PARTIAL_FILE with $PARTIAL_LINES" 
			head -n$CHUNK_END $CURRENT_FILE | tail -n$PARTIAL_LINES >> $PARTIAL_FILE
		done
	fi
done
