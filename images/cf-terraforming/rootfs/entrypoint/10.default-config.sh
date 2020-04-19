#!/bin/bash

### DEFAULT_CONFIG #############################################################

# Set container default command
# shellcheck disable=SC2034
DEFAULT_COMMAND="/usr/bin/cf-terraforming"

# Set default command sub-commands
# shellcheck disable=SC2034
DOCKER_COMMAND_ARGS=(
  $(${DEFAULT_COMMAND} --help |
  egrep '^[[:space:]]+[a-z]' |
  sed -E -e 's/^[[:space:]]+//' -e 's/[[:space:]].*//')
)

################################################################################
