. shell/config

if [ ! -d "$INV_INC_HOME_DIR_LINK" ]; then
    echo "Not bound!"
    exit 1
fi

echo "Removing link"
rm "$INV_INC_HOME_DIR_LINK"
echo "Done"