#!/bin/bash
set -e

# Create DataStore database and read-only user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    -- Create DataStore database
    CREATE DATABASE datastore;

    -- Create read-only user for DataStore
    CREATE USER datastore_ro WITH PASSWORD 'datastore';

    -- Grant necessary permissions
    GRANT ALL PRIVILEGES ON DATABASE datastore TO ckan;
    GRANT CONNECT ON DATABASE datastore TO datastore_ro;

    -- Connect to datastore database and set up permissions
    \c datastore

    -- Revoke permissions from public
    REVOKE CREATE ON SCHEMA public FROM PUBLIC;
    REVOKE USAGE ON SCHEMA public FROM PUBLIC;

    -- Grant permissions to ckan user
    GRANT CREATE ON SCHEMA public TO ckan;
    GRANT USAGE ON SCHEMA public TO ckan;

    -- Grant read-only permissions to datastore_ro
    GRANT USAGE ON SCHEMA public TO datastore_ro;

    -- Set default privileges for future tables
    ALTER DEFAULT PRIVILEGES FOR USER ckan IN SCHEMA public
       GRANT SELECT ON TABLES TO datastore_ro;
EOSQL

echo "DataStore database and users created successfully"
