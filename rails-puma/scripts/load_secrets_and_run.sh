#!/bin/sh

if [ ! -z "$SECRETS_FILE" ]
then
  echo "SECRETS_FILE env var is defined. Sourcing secrets file..."
  . "$SECRETS_FILE"
fi

echo "Running command: $*"
exec "$@"
