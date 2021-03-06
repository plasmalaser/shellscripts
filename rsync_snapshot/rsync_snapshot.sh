#!/bin/bash
#This incrementally snapshots /home (not crossing filesystem boundaries) via rsync
#use -q to shut the prompt up without ignoring errors (if trying to crontab)


#copy old time.txt to time2.txt

yes | cp /deepstorage/Backups/time.txt /deepstorage/Backups/time2.txt

#overwrite old time.txt file with new time

echo `date +”%F-%I%p”` > /deepstorage/Backups/time.txt

#make the log file

echo “” > /deepstorage/Backups/rsync-`cat /deepstorage/Backups/time.txt`.log

#rsync command

rsync -avhzxAXPR --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r --delete --fake-super --stats --log-file=/deepstorage/Backups/rsync-`cat /deepstorage/Backups/time.txt`.log --exclude-from ~/Scripts/rsync_snapshot/rsync_snapshot_exclude.txt --link-dest=/deepstorage/Backups/`cat /deepstorage/Backups/time2.txt` /home /deepstorage/Backups/`cat /deepstorage/Backups/time.txt`

#don’t forget to scp the log file and put it with the backup (just mv the one earlier into the rsync snapshot's root)

mv /deepstorage/Backups/rsync-`cat /deepstorage/Backups/time.txt`.log /deepstorage/Backups/`cat /deepstorage/Backups/time.txt`
