FROM postgres:14

# Install gettext-base for envsubst
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

# Copy custom PostgreSQL configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Fix permissions
RUN chmod -R 755 /docker-entrypoint-initdb.d && \
    chown -R postgres:postgres /docker-entrypoint-initdb.d

# Expose PostgreSQL port
EXPOSE 5432

# Ensure database starts and stays running
CMD ["docker-entrypoint.sh", "postgres"]
