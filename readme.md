# My Postgres Service

This repository contains the configuration for a centralized PostgreSQL node deployed via CapRover. The setup is tailored for logical replication and initializes multiple databases for different applications:

- **metabase**
- **n8n**
- **fleet-mgt**

## Repository Contents

- **Dockerfile:** Builds the PostgreSQL container using the official image, with a custom configuration and initialization scripts.
- **captain-definition:** CapRover deployment configuration.
- **postgresql.conf:** Custom PostgreSQL configuration optimized for logical replication.
- **init-scripts/init.sql.template:** SQL template for creating databases and roles. Passwords are defined via environment variables.
- **init-scripts/init.sh:** Shell script that substitutes environment variables into the SQL template and executes it.
- **README.md:** This documentation.

## Deployment

1. Push this repository to your Git provider.
2. In CapRover, set the following environment variables for your PostgreSQL app:
   - `POSTGRES_USER`
   - `POSTGRES_PASSWORD`
   - `POSTGRES_DB` (typically a default DB used during initialization)
   - `METABASE_PASSWORD`
   - `NN8N_PASSWORD`
   - `FLEET_MGT_PASSWORD`
3. Connect your CapRover instance to the repository.
4. Deploy the app via the CapRover dashboard or CLI.
5. On first startup, the initialization script in `/docker-entrypoint-initdb.d/` will create the databases and roles using the provided environment variables.
