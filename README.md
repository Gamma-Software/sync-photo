# sync-photo
I script the synchronization of my SDCard camera with my NAS when the SDCard is plugged into the SDCard reader.

# Requirements
Curl must be installed on the computer as such `sudo apt-get install curl`

# Usage
Call the script with the following arguments 
`./sync.sh -u=<user> -d=<device> -m=<mounting_point> -i=<input_path> -o=<output_path> -b=<bot_id> -c=<chat_id>`
Where:
* `-u=<user>` the photos will be owned by this user
* `-d=<device>` is the name of the SDCard reader, e.g. `/dev/sdc1`
* `-m=<mounting_point>` is the path to the mounting point of the SDCard, where the device will be mounted
* `-i=<input_path>` is the path to the input folder, where the photos are stored in the sdcard. It should be something like `<mounting_point>/DCIM`
* `-o=<output_path>` is the path to the output folder, where the photos will be synced
* `-b=<bot_id>` is the Telegram bot ID
* `-c=<chat_id>` is the Telegram chat ID

# Best practices
To automatically sync the photos when the sdcard is plugged in (as it's the main reason the script is created), first create a udev rule in the folder `/etc/udev/rules.d/` with the name of your choice. It should look like this: `99.sdcard.rules` with the content:
```KERNEL=="sdc1" SYMLINK+="sdcard", RUN+="/bin/bash /<path_to_script>/sync.sh -u=<user> -d=<device> -m=<mounting_point> -i=<input_path> -o=<output_path> -b=<bot_id> -c=<chat_id>"```\
Notice that the symlink *sdcard* will be the `-m=<mounting_point>` parameter, here `-m=/dev/sdcard`
Each time the sdcard will be plugged in, the script will be called.