#!/bin/bash

pg_config_dir="/etc/postgresql/9.3/main"

db_dir="/var/lib/postgresql/9.3/main"
# replication user that will be created on master
db_user="repl"
db_password="secret"

master_host="master.db.example.com"
master_port="5432"

slave_host="slave.db.example.com"

# file living on slave with instruction on how to connect to master
recovery_file="$db_dir/recovery.conf"

# Once this file is created, slave stops replication and is ready to be used
trigger_file="$pg_config_dir/GETUP"
