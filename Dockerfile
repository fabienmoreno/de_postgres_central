# Dockerfile
FROM postgres:14

# Copy the custom PostgreSQL configuration file
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy initialization scripts into the container
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Ensure the init script is executable
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Expose the PostgreSQL default port
EXPOSE 5432

# Start PostgreSQL with the custom configuration file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
