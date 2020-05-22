#!/bin/sh

set -eu

# Set deploy key
SSH_PATH="$HOME/.ssh"
mkdir "$SSH_PATH"
echo "$DEPLOY_KEY" > "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key"


# Do deployment
sh -c "rsync $FIRST_ARGS -e 'ssh -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no' $SECOND_ARGS $GITHUB_WORKSPACE/ $THIRD_ARGS"

if [[ !-z "${SERVER_HOST}" ]]; then
	sh -c "ssh -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no $SERVER_HOST '$RESTART_COMMAND'"
fi