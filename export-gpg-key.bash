#! /usr/bin/env bash

####################  E X P O R T _ P R I V A T E _ K E Y  #####################

gpg -K
echo "select private key"
read -r KEYID
gpg --output pubkey.gpg --export "$KEYID"
echo REMEMBER THE COMING PASS-PHRASE
gpg --output - --export-secret-key "$KEYID" | \
   cat pubkey.gpg - | \
   gpg --armor --output keys.asc --symmetric --cipher-algo AES256
ls -l pubkey.gpg keys.asc