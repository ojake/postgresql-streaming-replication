Postgres hot stand-by streaming replication
===========================================

This is the setup i use for postgres hot standby.
I use it with one master and one slave, but I guess it should be pretty simple to extend that to more hosts.


## Files

* cust.postgres.conf  -- Misc custom settings not related to standby.
* master.conf -- config file for master.
* slave.conf -- config file for slave.
* start-slave.sh -- script for igniting the replication on slave.
* prepare-master.sh -- prepare master.
* config.sh -- users/paswords/hosts etc.

## Howto

* Assuming postgres is already installed.

* To avoid messing up with default postgres config, on both master and slave, add just one line to postgresql.conf (on my debian it's /etc/postgresql/``ver``/main/postgresql.conf):

    - [ ] echo "include_dir = 'conf.d'" >> /etc/postgresql/``ver``/main/postgresql.conf

* And create conf.d dir for all custom config options (on both master and slave):

    - [ ] mkdir /etc/postgresql/``ver``/main/conf.d

* Copy master.conf to conf.d on master host, and slave.conf on slave host.

    <span># on master</span>

    - [ ] cp master.conf /etc/postgresql/``ver``/main/conf.d/

    <span># on slave</span>

    - [ ] cp slave.conf /etc/postgresql/``ver``/main/conf.d/

* - [ ] Update config.sh with your values!

* Prepare and restart master
    
    - [ ] sudo -u postgres ./prepare-master.sh
    
    - [ ] /etc/init.d/postgresql restart

* Stop slave

    - [ ] /etc/init.d/postgresql stop

* Initiate replication and start slave

    - [ ] sudo -u postgres ./start-slave.sh
    
    - [ ] /etc/init.d/postgresql/start
