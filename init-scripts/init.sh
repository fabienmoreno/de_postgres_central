#!/bin/bash
set -e

# Ensure the script runs as postgres user
if [ "$(whoami)" != "postgres" ]; then
    echo "Error: This script must be run as postgres user" >&2
    exit 1
fi

# Ensure the template file exists before substitution
if [ ! -f /docker-entrypoint-initdb.d/init.sql.template ]; then
  echo "Error: init.sql.template is missing!" >&2
  exit 1
fi

# Fix permissions before writing to init.sql
chown postgres:postgres /docker-entrypoint-initdb.d/init.sql.template
chmod 644 /docker-entrypoint-initdb.d/init.sql.template

# Substitute environment variables
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

# Fix permissions for init.sql
chown postgres:postgres /docker-entrypoint-initdb.d/init.sql
chmod 644 /docker-entrypoint-initdb.d/init.sql

# Ensure PostgreSQL is ready before executing
until pg_isready -h 127.0.0.1 -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL to start..."
  sleep 2
done

# Execute the resulting SQL script
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init.sql
