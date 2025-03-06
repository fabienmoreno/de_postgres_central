# Use official PostgreSQL image
FROM postgres:14

# Copy custom PostgreSQL configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Ensure scripts are executable and writable
RUN chmod -R 755 /docker-entrypoint-initdb.d && \
    chown -R postgres:postgres /docker-entrypoint-initdb.d

# Expose PostgreSQL port
EXPOSE 5432

# Add a health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD pg_isready -h 127.0.0.1 -U "$POSTGRES_USER" || exit 1

# Start PostgreSQL with custom config
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
