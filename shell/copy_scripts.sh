. shell/config

if [ ! -d "$INV_INC_HOME_DIR_LINK" ]; then
    echo "Not bound!"
    exit 1
fi

if [ ! -d "$LOCAL_SOURCE_DIR" ]; then
	mkdir "$LOCAL_SOURCE_DIR"
fi

if [ "$(ls -A "$LOCAL_SOURCE_DIR")" ]; then
	echo "\"$LOCAL_SOURCE_DIR\" directory is not empty"
	exit 1
fi

echo "Extracting scripts into \"$LOCAL_SCRIPTS_DIR\""

7z x -o"$LOCAL_SCRIPTS_DIR" "$REMOTE_SCRIPTS_ZIP" > /dev/null

echo "Copying lua files"

cp "$REMOTE_MAIN_LUA" "$LOCAL_MAIN_DEBUG_LUA"
cp "$REMOTE_MAIN_LUA" "$LOCAL_MAIN_RELEASE_LUA"
cp "$REMOTE_MOAI_LUA" "$LOCAL_MOAI_LUA"

echo "Done"