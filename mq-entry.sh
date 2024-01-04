#!/bin/bash

#   entry.sh
#
#   Entrypoint script will check if we have a MailerQ license, if not it will
#   fetch the license using the LICENSE_KEY variable or throw an error if the
#   variable is not set.
#
#   @author Sander Hansen <sander.hansen@copernica.com> 
#   @copyright 2023 Copernica BV
#

# if we do not have a license but a key variable is set, we fetch the license
if [[ -n "${LICENSE_KEY}" ]]; then
    echo "y" | mailerq --fetch-license ${LICENSE_KEY}
# if we do not have a license and no key variable is set, we throw an error
elif [[ ! -f /etc/mailerq/license.txt ]]; then
    echo "License file does not exist. Either pass a LICENSE_KEY variable using -e or bind /etc/mailerq/license.txt using -v."
    exit 1
fi

# we execute the set command
exec "$@"