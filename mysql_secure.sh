#!/bin/bash

# Check the bash shell script is being run by root
if [[ $EUID -ne 0 ]]; then
    echo "[ERROR] This script must be run as root" 1>&2
    exit 1
fi

# Check input params
if [ -n "${1}" -a -z "${2}" ]; then
    # Setup root password
    CURRENT_MYSQL_PASSWORD=''
    NEW_MYSQL_PASSWORD="${1}"
elif [ -n "${1}" -a -n "${2}" ]; then
    # Change existing root password
    CURRENT_MYSQL_PASSWORD="${1}"
    NEW_MYSQL_PASSWORD="${2}"
else
    echo "Usage:"
    echo "  Setup MariaDB root password: ${0} 'your_current_root_password'"
    echo "  Change MariaDB root password: ${0} 'your_old_root_password' 'your_new_root_password'"
    exit 1
fi

# Check expect package installed
if ! command -v expect &> /dev/null
then
    echo "[ERROR] expect could not be found"
    exit 1
fi

SECURE_MYSQL=$(expect -c "

set timeout 3
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$CURRENT_MYSQL_PASSWORD\r\"

expect \"unix_socket authentication?\"
send \"y\r\"

expect \"root password?\"
send \"y\r\"

expect \"New password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

# Execute mysql_secure_installation
echo "${SECURE_MYSQL}"

exit 0
