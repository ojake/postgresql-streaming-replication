#!/bin/bash

. ./config.sh

# Create replication user on master
psql -c "CREATE USER $db_user REPLICATION ENCRYPTED PASSWORD $db_password;"

# Allow remote password connection for replication user
echo "hostssl   replication $db_user    $slave_host     md5" >> "$pg_config_dir/pg_hba.conf"
