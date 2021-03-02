# writes to standard output the name of the distro
# currently running
#
# throws:
#     _ERROR_CANNOT_IDENTITY_DISTRO: if The distribution could not be identified automatically
_get_distro_name () {
	if [ -f /etc/os-release ]; then
    	# freedesktop.org and systemd
    	. /etc/os-release
    	OS=$NAME
    	# VER=$VERSION_ID
	elif which lsb_release 1>/dev/null 2>&1; then
    	# linuxbase.org
    	OS=$(lsb_release -si)
    	# VER=$(lsb_release -sr)
	elif [ -f /etc/lsb-release ]; then
    	# For some versions of Debian/Ubuntu without lsb_release command
    	. /etc/lsb-release
    	OS=$DISTRIB_ID
    	# VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
    	# Older Debian/Ubuntu/etc.
    	OS=Debian
    	# VER=$(cat /etc/debian_version)
	elif [ -f /etc/SuSe-release ]; then
    	# Older SuSE/etc.
    	OS=SuSe
	elif [ -f /etc/redhat-release ]; then
    	# Older Red Hat, CentOS, etc.
    	OS=redhat
	else
		return $_ERROR_CANNOT_IDENTITY_DISTRO
	fi &&

	printf "%s" "$OS"
}

_get_distro_name "$@"
