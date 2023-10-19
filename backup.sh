#!/bin/bash

# Check if the number of arguments is correct
if [[ $# != 2 ]]; then
  echo "Usage: $0 target_directory_name destination_directory_name"
  exit 1
fi

# Check if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Invalid directory path provided"
  exit 1
fi

# Task 1: Set the target and destination directory paths
targetDirectory=$1
destinationDirectory=$2

# Task 2: Print the target and destination directory paths
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# Task 3: Get the current timestamp
currentTS=$(date +%s)

# Task 4: Create the backup file name with a timestamp
backupFileName="backup-[$currentTS].tar.gz"

# Task 5: Get the current working directory
origAbsPath=$(pwd)

# Task 6: Change to the destination directory and get its absolute path
cd $destinationDirectory
destDirAbsPath=$(pwd)

# Task 7: Change back to the original working directory and then to the target directory
cd $origAbsPath
cd $targetDirectory

# Task 8: Calculate the timestamp for yesterday
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# Declare an array to store files to be backed up
declare -a toBackup

# Task 9: Iterate over files in the target directory
for file in $(ls); do
  # Task 10: Check if the file is modified in the last 24 hours
  if [[ `date -r $file +%s` -gt $yesterdayTS ]]; then
    # Task 11: Add the file to the list of files to be backed up
    toBackup+=("$file")
  fi
done

# Task 12: Create a tar.gz archive of the selected files
tar -czvf $backupFileName "${toBackup[@]}"

# Task 13: Move the backup file to the destination directory
mv $backupFileName $destDirAbsPath

# Congratulations! You've completed the final project.
