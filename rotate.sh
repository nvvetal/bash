#!/bin/bash

log_directory="/YOUR_LOGS_DIR/"
min_period_days=7 
current_ts=$(date +%s -d "$(date +%Y-%m-%d)")
current_dt=$(date +%Y-%m-%d)
echo "DIR: $log_directory"
echo "CURRENT DAY: $current_dt, MIN PERIOD: $min_period_days DAYS"
cd "$log_directory"

# Loop through files in log_directory
for file in *
do
  [ -f "$file" ] || continue # ignore directories and things
  filesize=$(stat -c%s "$file")
  elem=`echo $file | perl -ne 'my ($dt) = $_ =~ /(\d+\-\d+\-\d+)\.log$/; print $dt;'`;
  file_ts=$(date +%s -d "$elem")
  if  ((file_ts + min_period*24*3600 < current_ts))
  then
    echo "REMOVING: $file";
    `rm $log_directory$file`
  fi

done
