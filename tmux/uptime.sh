#!/bin/bash
#
# this script returns an uptime and load average for tmux status line:
#   10d 10:06:18 (3.30 5.52 8.04 12c)
#    0d 03:56:03 (0.00 0.16 0.98 2c)

# MacOS and Linux differs in how we retrieve the information
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS: Calculate difference between current time and boot time
    boot_time=$(sysctl -n kern.boottime | awk '{print $4}' | tr -d ',')
    now=$(date +%s)
    uptime_seconds=$((now - boot_time))
    # get the load average using
    load_avg=$(uptime | awk '{print $(NF-2), $(NF-1), $NF}' | tr -d ',')
    # number of cpu cores
    cores=$(sysctl -n hw.logicalcpu)
    # macOS: hw.memsize returns bytes -> convert to GB (rounded)
    ram_gb=$(sysctl -n hw.memsize | awk '{printf "%d", ($1 / 1024 / 1024 / 1024) + 0.5}')
else
    # Linux (and others): Read directly from /proc/uptime
    uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
    # get the load average, faster than macos variant
    load_avg=$(cut -d " " -f 1-3 /proc/loadavg)
    # number of cpu cores
    cores=$(nproc)
    # Linux: MemTotal returns kB -> convert to GB (rounded)
    ram_gb=$(awk '/MemTotal/ {printf "%d", ($2 / 1024 / 1024) + 0.5}' /proc/meminfo)
fi

d=$((uptime_seconds / 86400))
h=$((uptime_seconds % 86400 / 3600))
m=$((uptime_seconds % 3600 / 60))
s=$((uptime_seconds % 60))

printf "%dd %02d:%02d:%02d (%s %dc/%sg)" "$d" "$h" "$m" "$s" "$load_avg" "$cores" "$ram_gb"
