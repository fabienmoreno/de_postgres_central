-- init.sql.template

-- Create databases for different applications
CREATE DATABASE metabase;
CREATE DATABASE n8n;
CREATE DATABASE fleetmgt;  -- Quotes are required for names with hyphens

-- Create roles and grant privileges

-- For Metabase
CREATE ROLE metabase_user WITH LOGIN PASSWORD '${METABASE_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE metabase TO metabase_user;

-- For n8n
CREATE ROLE n8n_user WITH LOGIN PASSWORD '${NN8N_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n_user;

-- For Fleet Management
CREATE ROLE fleet_mgt_user WITH LOGIN PASSWORD '${FLEET_MGT_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE fleetmgt TO fleet_mgt_user;
