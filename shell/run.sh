. shell/config

if [ ! -d "$INV_INC_HOME_DIR_LINK" ]; then
    echo "Not bound!"
    exit 1
fi

################################
######### CHECK PHASE ##########

if [ $# -ne 1 ] || ([ "$1" != "debug" ] && [ "$1" != "release" ] && [ "$1" != "steam" ]); then
    echo "Use: run debug|release|steam"
    exit 1
else
    RUN_TYPE=$1
fi

################################
####### LINK AND BACKUP ########

echo "[$RUN_TYPE] Creating links and making backups"

# link main.lua
if [ "$RUN_TYPE" = "debug" ]; then
    ln --backup=simple "$LOCAL_MAIN_DEBUG_LUA" "$REMOTE_MAIN_LUA"
else
    ln --backup=simple "$LOCAL_MAIN_RELEASE_LUA" "$REMOTE_MAIN_LUA"
fi

# link moai.lua
ln --backup=simple "$LOCAL_MOAI_LUA" "$REMOTE_MOAI_LUA"

# link debug.lua
ln --backup=simple "$LOCAL_DEBUG_LUA" "$REMOTE_DEBUG_LUA"

# link scripts
REMOTE_SCRIPTS_WINPATH=$(cygpath -w "$REMOTE_SCRIPTS_DIR")
LOCAL_SCRIPTS_WINPATH=$(cygpath -w "$(readlink -f "$LOCAL_SCRIPTS_DIR")")

cmd /c "mklink /D \"$REMOTE_SCRIPTS_WINPATH\" \"$LOCAL_SCRIPTS_WINPATH\""

################################
############# RUN ##############

echo "Starting InvisibleInc"

cd "$INV_INC_HOME_DIR"
"$INV_INC_EXECUTABLE"
cd -

if [ "$RUN_TYPE" = "steam" ]; then
	sleep $TIME_TO_WAIT_FOR_INV_INC_PROCESS

	# do while emulation
	while : ; do
		cmd /c "tasklist /fi \"IMAGENAME eq $INV_INC_EXECUTABLE_NAME\" | findstr /i /n $INV_INC_EXECUTABLE_NAME"
		[[ "$?" -eq 0 ]] || break
		sleep $INV_INC_PROCESS_IS_RUNNING_CHECK_PERIOD
	done
fi

################################
########### RESTORE ############

echo "Restoring state"

# replace main.lua with main.lua~
rm -f "${REMOTE_MAIN_LUA}" # mv does not replace if files are equal
mv -f "${REMOTE_MAIN_LUA}~" "${REMOTE_MAIN_LUA}"

# replace moai.lua with moai.lua~
rm -f "${REMOTE_MOAI_LUA}"
mv -f "${REMOTE_MOAI_LUA}~" "${REMOTE_MOAI_LUA}"

# replace moai.lua with moai.lua~
rm -f "${REMOTE_DEBUG_LUA}"
mv -f "${REMOTE_DEBUG_LUA}~" "${REMOTE_DEBUG_LUA}"

# remove scripts dir link
rm -f "${REMOTE_SCRIPTS_DIR}"

echo "Done"
