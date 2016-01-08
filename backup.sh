#!/bin/bash

date=$(date -I)

filename=$1

# alternatively create file to be backuped if needed
# Gitlab:
# gitlab-rake gitlab:backup:create
# filename="$(ls -t /var/opt/gitlab/backups/ | head -1)"
#
# Mysql:
# mysqldump -u readonly -h localhost --all-databases > "$filename"

zippw="encryption password"
webloginescaped="backupuser:backupuserpassword"
remotedir="https://owncloud.host.tld/remote.php/webdav/folder/" # make sure folder exists
filenamezip="${date}-${filename}.zip"

zip -e -P "$zippw" -9 "$filenamezip" "$filename"

curl -T "$filenamezip" -u "$webloginescaped" "${remotedir}${filenamezip}"

# optional delete created file
# rm "$filename"

rm "$filenamezip"
