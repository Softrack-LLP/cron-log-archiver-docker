### About

Based on [this](https://stackoverflow.com/questions/44624187/how-to-configure-compressed-logs-in-wildfly) answer there is no easy way to configure log compression.
This docker image runs cron and every minute tries to find any rotated log to compress them and delete source

### Usage

To use this docker image it is enough to define the following service in your docker compose file(set your own '/path/to/logs/folder'):

```yml
version: '2'
services:
    cron-task:
        image: softrackkz/cron-log-archiver:latest
        volumes:
             - /path/to/logs/folder:/logs-to-filter
```

### Test

In case you are going to change it this is how it can be done:

First let's create some logs:

```bash
rm -rf /tmp/sample
mkdir /tmp/sample
echo 'some info' > /tmp/sample/access2018-10-26-1..log
echo 'some info' > /tmp/sample/access2018-10-26..log
echo 'some info' > /tmp/sample/access2018-10-27..log
echo 'some info' > /tmp/sample/access2018-10-28..log
echo 'some info' > /tmp/sample/access2018-10-29..log
echo 'some info' > /tmp/sample/access.log
echo 'some info' > /tmp/sample/epay-messages
echo 'some info' > /tmp/sample/server.log
echo 'some info' > /tmp/sample/server.log.2018-10-29
echo 'some info' > /tmp/sample/timer_interceptor.log
echo 'some info' > /tmp/sample/timer_interceptor.log.2018-10-25
echo 'some info' > /tmp/sample/timer_interceptor.log.2018-10-26
echo 'some info' > /tmp/sample/timer_interceptor.log.2018-10-27
echo 'some info' > /tmp/sample/timer_interceptor.log.2018-10-28
echo 'some info' > /tmp/sample/timer_interceptor.log.2018-10-29
```

build docker image(or pull existing)

```bash
./build.sh
```

create docker-compose file and run it:

```bash
CRON_ARCHIVER_FOLDER='/tmp/cron-archiver'
rm -rf $CRON_ARCHIVER_FOLDER
mkdir $CRON_ARCHIVER_FOLDER
cat << EOF > /tmp/cron-archiver/cron-task.yml
version: '2'
services:
    cron-task:
        image: softrackkz/cron-log-archiver:latest
        volumes:
             - /tmp/sample:/logs-to-filter
EOF
cd $CRON_ARCHIVER_FOLDER
docker-compose -f cron-task.yml up -d
```

test it:

```bash
ls /tmp/sample
```

to check logs:

```bash
docker exec -it $(docker ps | grep 'softrackkz/cron-log-archiver:latest' | awk '{print $1}') /bin/bash
```
