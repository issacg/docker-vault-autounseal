#!/usr/bin/dumb-init /bin/sh
set -e

if [ -n "$VAULT_UNSEAL_URL" ]; then
    echo "Pinging $VAULT_UNSEAL_URL ..."
    wget "$VAULT_UNSEAL_URL" 
fi

echo "Starting Vault..."
exec /usr/local/bin/docker-entrypoint.sh "$@"