#!/bin/sh

if [ ! -z "$SECRETS_FILE" ]
then
  echo "SECRETS_FILE env var is defined. Sourcing secrets file..."
  # set -a exports plain KEY=value lines too, so they reach the app after exec
  set -a
  . "$SECRETS_FILE"
  set +a
fi

echo "Running command: $*"
exec "$@"
