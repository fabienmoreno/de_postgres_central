#!/bin/bash
set -e

# Ensure the template file exists before substitution
if [ ! -f /docker-entrypoint-initdb.d/init.sql.template ]; then
  echo "Error: init.sql.template is missing!" >&2
  exit 1
fi

# Substitute environment variables
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

# Ensure PostgreSQL is ready before executing
until pg_isready -h 127.0.0.1 -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL to start..."
  sleep 2
done

# Execute the resulting SQL script
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init.sql
