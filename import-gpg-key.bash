#! /usr/bin/env bash

###################  I M P O R T _ P R I V A T E _ K E Y  ######################

gpg --no-use-agent --output - keys.asc | gpg --import
