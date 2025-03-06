# Dockerfile
FROM postgres:14

# Copy the custom PostgreSQL configuration file
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy initialization scripts including the missing template
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Ensure all scripts are executable
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Expose the PostgreSQL default port
EXPOSE 5432

# Add a HEALTHCHECK that uses pg_isready to check the database status
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=5 \
  CMD pg_isready -U "$POSTGRES_USER" -d postgres || exit 1

# Start PostgreSQL using the custom configuration file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
