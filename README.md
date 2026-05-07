# soju
Some scripts helpful for soju users

*extractlogs.sh*

Usage: ./extractlogs.sh database.sqlite output_folder

This script extract logs to a specified folder creating txt files for each channel.\n
The database sqlite parameter must be the *main db** file, 
for example main.db and must be with its main.db-shm and main.db-wal

Example

./extractlogs.sh /etc/soju/main.db logs

It creates a directory "logs" where put all channels logs grouped by channel name with lines like this:

2026-05-03 - [14:07:18] - user1 (╯°□°)╯︵ ┻━┻

2026-05-03 - [14:07:22] - user2 this is really cool
