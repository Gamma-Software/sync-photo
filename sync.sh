#!/bin/bash
for i in "$@"; do
  case $i in
    -u=*|--username=*)
      USERNAME="${i#*=}"
      shift # past argument=value
      ;;
    -d=*|--device=*)
      DEVICE="${i#*=}"
      shift # past argument=value
      ;;
    -m=*|--mount=*)
      MOUNT="${i#*=}"
      shift # past argument=value
      ;;
    -i=*|--input=*)
      INPUT="${i#*=}"
      shift # past argument=value
      ;;
    -o=*|--output=*)
      OUTPUT="${i#*=}"
      shift # past argument=value
      ;;
    -c=*|--chat_id=*)
      CHAT_ID="${i#*=}"
      shift # past argument=value
      ;;
    -b=*|--bot_id=*)
      BOT_ID="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

su "root" -c "logger -s "Synchonizer:" $(whoami)"

# if the device exists
if [ -e $DEVICE ] && [ -z "$(ls -A $MOUNT)" ]; then
    #su - ${USERNAME} -c "curl -s --data 'text=Uploading photos...' --data 'chat_id=${CHAT_ID}' 'https://api.telegram.org/bot'${BOT_ID}'/sendMessage' > /dev/null"
    logger -s "Synchronizer:${DEVICE}"
    mount ${DEVICE} ${MOUNT}
    #rsync -avp --chown=${USERNAME}:${USERNAME} --progress ${INPUT}/* ${OUTPUT} > /home/valentinrudloff/workspace/sync/sync.log
    #umount ${DEVICE}
    #su - ${USERNAME} -c "curl -s --data 'text=Photo uploaded! You can remove the SDCard' --data 'chat_id=${CHAT_ID}' 'https://api.telegram.org/bot'${BOT_ID}'/sendMessage' > /dev/null"
else
    logger -s "Synchronizer: fail"
fi
