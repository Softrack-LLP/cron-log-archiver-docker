FROM ubuntu:18.04
MAINTAINER magzhan.karassayev@allpay.kz

# source and credits:
# https://www.ekito.fr/people/run-a-cron-job-with-docker/

# install cron
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y cron

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/logarchiver-cron

ADD archive-wildfly-logs.sh /usr/bin/archive-wildfly-logs.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/logarchiver-cron

RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
