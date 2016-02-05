cd "$(dirname "$0")"
. shell/config

################################
######### CHECK PHASE ##########

if [ $# -ne 1 ]; then
    echo "Path to Invisible Inc. installation directory required!"
    exit 1
fi

INV_INC_HOME_DIR=$(readlink -f "$1")
#echo $INV_INC_HOME_DIR

if [ -d "$INV_INC_HOME_DIR_LINK" ]; then
	if [ "$(readlink -f "$INV_INC_HOME_DIR_LINK")" = "$INV_INC_HOME_DIR" ]; then
		echo "Already bound to that directory"
		exit 0
	fi
	
    echo "WARNING: Already bound to \"$(readlink -f "$INV_INC_HOME_DIR_LINK")\""

    read -p "Do you want to rebind to a new location (y/n)? " answer
    case ${answer:0:1} in
        y|Y )
			. shell/unbind.sh
        ;;
        * )
            echo "Binding aborted"
            exit 1
        ;;
    esac
fi

if [ ! -d "$INV_INC_HOME_DIR" ]; then
    echo "Specified directory not found!"
    exit 1
fi

if [ ! -f "${INV_INC_HOME_DIR}/invisibleinc" ]; then
    echo "\"$INV_INC_HOME_DIR\" is not an Invisible Inc. installation directory!"
    exit 1
fi

###############################
######### BIND PHASE ##########

echo "Binding"

INV_INC_HOME_DIR_WINPATH=$(cygpath -w "$INV_INC_HOME_DIR")
INV_INC_HOME_DIR_LINK_WINPATH=$(cygpath -w "$(readlink -f "$INV_INC_HOME_DIR_LINK")")
#echo "$INV_INC_HOME_DIR_WINPATH"
#echo "$INV_INC_HOME_DIR_LINK_WINPATH"

cmd /c "mklink /D \"$INV_INC_HOME_DIR_LINK_WINPATH\" \"$INV_INC_HOME_DIR_WINPATH\""

echo "Success"


###############################
### COPY SCRIPTS AND PATCH ####

if [ ! -d "$LOCAL_SOURCE_DIR" ]; then
	echo "Copying scripts"
	. shell/copy_scripts.sh
	. shell/patch.sh
fi