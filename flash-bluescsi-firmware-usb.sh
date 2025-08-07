#!/bin/bash
cd "$(dirname "$0")"
BIN_FILE=${1:-./.pio/build/STM32F1-USB/firmware.bin}
#./find-commands.sh || exit $?
echo "Building $BIN_FILE"
pio run -e STM32F1-USB
exit_status=$?
if [ $exit_status -ne 0 ]; then
        echo "Build failed, aborting"
        exit $exit_status
fi
echo
echo "Flashing $BIN_FILE via USB"
echo
echo "* Move BOOT1 to 1 (Jumper nearest the RESET button on the BluePill)"
echo "* Connect via USB to the BluePill"
dfu-util -d 0x1eaf:0x003 --download ./${BIN_FILE} --alt 2 -w
echo
echo "* Move BOOT1 back to 0"
echo "* Disconnect USB"
echo "Happy scuzzing!"
