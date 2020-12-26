# Different Tools For Linux OS

List of useful utilities with short description

## Process tools

* `ps` - Report a snapshot of the current processes
* `top` - Display Linux processes
    * `htop` - Interactive process viewer
* `pgrep, pkill` - Look up or signal processes based on name and other attributes
* `nice` - Run a program with modified scheduling priority
* `renice` - Alter priority of running processes
* `jobs` - List of running jobs
    * `fg` - Resume job execution in foreground
    * `bg` - Resume job execution in background
    * `nohup` - Run a command immune to hangups, with output to a non-tty
    * `disown` - Like `nohup`, but stops after closing terminal

## Net tools

* `nethogs` - Net top tool grouping bandwidth per process
* `iptraf` - Interactive Colorful IP LAN Monitor
* `netstat` - Print network connections, routing tables, interface statistics

## File tools

* `df` - Report file system disk space usage
    * `pydf` - Improved version of df
* `du` - Estimate file space usage
    * `ncdu` - Improved version of du
* `free` - Display amount of free and used memory in the system
* `vmstat` - Report virtual memory statistics
