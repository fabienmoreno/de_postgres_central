# My Postgres Service

This repository contains the configuration for a centralized PostgreSQL node deployed via CapRover. It is configured for logical replication and automatically initializes multiple databases for different applications:

- **metabase**
- **n8n**
- **fleetmgt**

## Repository Contents

- **Dockerfile:** Builds the PostgreSQL container using the official image, applies a custom configuration, and includes an integrated HEALTHCHECK.
- **captain-definition:** CapRover deployment configuration.
- **postgresql.conf:** Custom PostgreSQL configuration optimized for logical replication and connectivity.
- **init-scripts/init.sql.template:** SQL template for creating databases and roles (passwords injected via environment variables).
- **init-scripts/init.sh:** Shell script that substitutes environment variables into the SQL template and executes it.
- **README.md:** This documentation.

## Deployment Instructions

### 1. Create a New App in CapRover

- Log into the CapRover dashboard.
- Create a new app (e.g., `postgres-central`).

### 2. Connect Your Repository

- Set the deployment method to "Deploy from Git Repository."
- Provide the repository URL: `https://github.com/fabienmoreno/de_postgres_central.git`
- Select the branch to deploy (e.g., `main`).

### 3. Configure Environment Variables

In the app settings, add the following environment variables:

- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB` (the default database for initialization)
- `METABASE_PASSWORD`
- `NN8N_PASSWORD`
- `FLEET_MGT_PASSWORD`

### 4. Set Up Persistent Storage

- In CapRover, add a persistent storage volume mapping a host directory (e.g., `/data/postgres`) to `/var/lib/postgresql/data` in the container.
- This ensures that your PostgreSQL data survives container restarts and redeployments.

### 5. Deploy the App

- Click on "Deploy" in CapRover.
- The deployment process will build the image, run the initialization scripts (using your secure environment variables), and start the PostgreSQL service.
- The Docker HEALTHCHECK will regularly check the service status using `pg_isready`.

### 6. Monitoring and Auto-Restart

- **Restart Policy:** CapRover sets the container restart policy to "always" by default, ensuring automatic recovery from crashes.
- **Health Checks:** The integrated Docker HEALTHCHECK ensures PostgreSQL is responsive. If the health check fails, Docker marks the container as unhealthy, prompting a restart.
- **Monitoring:** Integrate additional monitoring tools (e.g., Prometheus with PostgreSQL exporters) to keep an eye on performance and uptime.

## Security and Access

- **TLS/SSL:** Consider enabling SSL in PostgreSQL for secure connections.
- **Firewall:** Configure your Ubuntu 22.04 VPS firewall to restrict access to port 5432 from trusted IP addresses.
- **Domain:** Optionally, assign a domain (e.g., `postgres-central.caprover.fabienmoreno.me`) for easier identification and secure access.

This setup ensures a robust, secure, and reliable PostgreSQL deployment on CapRover, making it easy to manage, monitor, and update via version-controlled files.
