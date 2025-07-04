# Server Backup Script
This is a bash shell script that uses [Screen](https://www.gnu.org/software/screen/) and [Cronjobs](https://cronitor.io/guides/cron-jobs) to backup a Minecraft server. *This script uses variables and is dependant upon file paths so make sure to amend this script with your setup*



## How does the script work?
It uses Screen using the `-X stuff` argument to send messages to everyone in the server (using `/tellraw`)
```bash
screen -r minecraft -X stuff 'tellraw @a ["",{"text":"III","obfuscated":true,"color":"green"},{"text":" BACKUP IN PROGRESS EXPECT SOME LAG ","color":"red"},{"text":"III","obfuscated":true,"color":"green"}]'$(echo -ne '\r')
```

It then turns off auto saving `/save-off` before manually saving `/save-all flush`
```bash
screen -R minecraft -X stuff "save-off $(printf '\r')"
```
```bash
screen -R minecraft -X stuff "save-all flush $(printf '\r')"
```

Backup the entire folder (**This is a variable, change before using**) using [Tar](https://www.gnu.org/software/tar/) with timestamp format
```bash
tar -cvzf $DATE_FOLDER/minecraft_backup_$DATE.tar.gz -C ~ minecraft
```

Turn back on auto saving `/save-on`

```bash
screen -r minecraft -X stuff 'tellraw @a ["",{"text":"III","obfuscated":true,"color":"red"},{"text":" BACKUP COMPLETED ","color":"green"},{"text":"III","obfuscated":true,"color":"red"}]\n'$(echo -ne '\r')
```
# Things to look out for
- This script uses variables, make sure to amend this to your situation
```bash
MINECRAFT_DIR=~/minecraft
BACKUP_DIR=~/server-backup
DATE=$(date +%Y-%m-%d_%H.%M)
DATE_FOLDER=$BACKUP_DIR/$DATE
```
- As this script uses Screen, make sure the screen name is changed or amended to your own screen name (I use minecraft for continuity's sake)
  - Creating a screen with the name **minecraft**
```bash
screen -S minecraft
```
 - Creating a screen with the name **server**
```bash
screen -S server
```
# Crontab
Crontabs are a way to automatically run a certain script with a given time or interval

a Cronjob that runs this script *every Monday at 3am* would look like this:
```bash
0 3 * * 1 ~/scripts/backup.sh
```
To learn more about how to use the cronjob's time and date system, use [this](https://crontab.guru/#0_3_*_*_1)

