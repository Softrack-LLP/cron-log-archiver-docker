#!/bin/bash

cd "/logs-to-filter"
ls | egrep '[0-9]{4}-[0-9]{2}-[0-9]{2}' | egrep -v '.*.tar.gz' | xargs -I{} bash -c 'echo archiving log file {}; tar -czvf {}.tar.gz {} && rm {} && echo done && echo'
