# soju
Some scripts helpful for soju users

*extractlogs.sh*
<img width="1073" height="652" alt="screenshot" src="https://github.com/user-attachments/assets/490fd31b-3fb7-463d-a4b1-116e3f1e510f" />


Usage: ./extractlogs.sh database.sqlite output_folder

This script extracts logs to a specified folder creating txt files for each channel.

The database sqlite parameter must be the **main db** file, 
for example main.db and must be with its main.db-shm and main.db-wal . Don't forget to make script executable with " chmod +x extractlogs.sh "

Example

./extractlogs.sh /etc/soju/main.db logs

It creates a directory "logs" where put all channels logs grouped by channel name with lines like this:

2026-05-03 - [14:07:18] - user1 (╯°□°)╯︵ ┻━┻

2026-05-03 - [14:07:22] - user2 this is really cool
