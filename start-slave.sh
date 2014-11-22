#!/bin/bash

. ./config.sh

# Empty old db 
rm -rf $db_dir

# Initialize base backup
export PGPASSWORD=$db_password
pg_basebackup -h $master_host -D $db_dir -U $db_user -v -P
PGPASSWORD=

# Create recovery.conf

echo "standby_mode = 'on'" > $recovery_file
echo "primary_conninfo = 'host=$master_host port=$master_port user=$db_user password=$db_password sslmode=require'" >> $recovery_file
echo "trigger_file = $trigger_file" >> $recovery_file
