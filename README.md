Postgres hot stand-by streaming replication
===========================================

This is the setup i use for postgres hot standby.
I use it with one master and one slave, but I guess it should be pretty simple to extend that to more hosts.

This could be further automated to just have one script for master and one for slave, I'll probably do it next time I have to set up streaming replication :)

## Files

* cust.postgres.conf  -- Misc custom settings not related to standby.
* master.conf -- config file for master.
* slave.conf -- config file for slave.
* start-slave.sh -- script for igniting the replication on slave.
* prepare-master.sh -- prepare master.
* config.sh -- users/paswords/hosts etc.

## Howto

* First step is installing postgres if not yet installed. Follow instructions for your distro from [postgres download website](http://www.postgresql.org/download)

* To avoid messing up with default postgres config, on both master and slave, add just one line to postgresql.conf (on my debian it's /etc/postgresql/9.3/main/postgresql.conf):

    echo "include_dir = 'conf.d'" >> /etc/postgresql/9.3/main/postgresql.conf

* And create conf.d dir for all custom config options (on both master and slave):

    mkdir /etc/postgresql/9.3/main/conf.d

* Copy master.conf to conf.d on master host, and slave.conf on slave host.

    <span># on master</span>
    cp master.conf /etc/postgresql/9.3/main/conf.d/

    <span># on slave</span>
    cp slave.conf /etc/postgresql/9.3/main/conf.d/

* Update config.sh with your values!

* Prepare and restart master
    
    sudo -u postgres ./prepare-master.sh
    /etc/init.d/postgresql restart

* Stop slave

    /etc/init.d/postgresql stop

* Initiate replication and start slave

    sudo -u postgres ./start-slave.sh
    /etc/init.d/postgresql/start
