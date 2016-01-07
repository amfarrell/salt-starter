export DO_TOKEN='Insert your digital ocean token here after renaming this "nocommit.sh"'
export RSA_PRIVATE_KEY_PATH='~/.ssh/id_rsa'
vagrant $@
unset DO_TOKEN
unset RSA_PRIVATE_KEY_PATH
