#!/bin/bash

# set date format for logstash
LC_TIME="POSIX"
# set iostat date format for logstash
export S_TIME_FORMAT=ISO

sar -t -u ALL 1 | /usr/bin/perl /root/timestamp.pl > /var/log/sar/sar_cpu.log &
sar -q 1 | /usr/bin/perl /root/timestamp.pl > /var/log/sar/sar_load.log &
sar -r 1 | /usr/bin/perl /root/timestamp.pl > /var/log/sar/sar_memory_util.log &
sar -R 1 | /usr/bin/perl /root/timestamp.pl > /var/log/sar/sar_memory.log &

iostat -tdmx 1 > /var/log/sar/iostat_disk.log &