#!/bin/sh

set -e

if [ -n "$RUBYGEMS_AUTH_TOKEN" ]; then
  GEM_CREDENTIALS="$HOME/.gem/credentials"

  echo -e "---\n:rubygems_api_key: $RUBYGEMS_AUTH_TOKEN" > "$GEM_CREDENTIALS"
  chmod 0600 "$GEM_CREDENTIALS"
fi

sh -c "gem $*"