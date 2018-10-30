#!/bin/env bash

# Get working directory. It is directory where this script is located
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Is a useful one-liner which will give you the full directory name
# of the script no matter where it is being called from
WORKING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo docker build --rm -t allpay.kz/cron-log-archiver "$WORKING_DIR"
