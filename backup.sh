#!/bin/bash

# Set variables for folders
MINECRAFT_DIR=~/minecraft
BACKUP_DIR=~/server-backup
DATE=$(date +%Y-%m-%d_%H.%M)
DATE_FOLDER=$BACKUP_DIR/$DATE

# Create backup directory and date folder if they don't exist
mkdir -p $DATE_FOLDER

# Tell server members backup is happening
screen -r minecraft -X stuff 'tellraw @a ["",{"text":"III","obfuscated":true,"color":"green"},{"text":" BACKUP IN PROGRESS EXPECT SOME LAG ","color":"red"},{"text":"III","obfuscated":true,"color":"green"}]'$(echo -ne '\r') 

# Wait 1 second
sleep 1

# Turn off automatic saving
screen -R minecraft -X stuff "save-off $(printf '\r')"

# Wait 1 second
sleep 1

# Save manually save minecraft server
screen -R minecraft -X stuff "save-all flush $(printf '\r')"

# Wait 10 seconds for saving to finish
sleep 10

# Create backup with timestamp in the dated folder
tar -cvzf $DATE_FOLDER/minecraft_backup_$DATE.tar.gz -C ~ minecraft

# Wait 15 seconds for minecraft server to compress
sleep 15

# Turn on automatic saving
screen -R minecraft -X stuff "save-on $(printf '\r')"

# Wait 1 second
sleep 1

# Tell server members backup is complete
screen -r minecraft -X stuff 'tellraw @a ["",{"text":"III","obfuscated":true,"color":"red"},{"text":" BACKUP COMPLETED ","color":"green"},{"text":"III","obfuscated":true,"color":"red"}]\n'$(echo -ne '\r')




