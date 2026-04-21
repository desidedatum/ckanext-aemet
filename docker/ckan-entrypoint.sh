#!/bin/bash
set -e

echo "Waiting for database..."
until python3 -c "import psycopg2; psycopg2.connect('postgresql://ckan:ckan@db/ckan')" 2>/dev/null; do
  echo "Database not ready yet, waiting..."
  sleep 2
done
echo "Database is ready!"

# Install extension in development mode
echo "Installing ckanext-aemet extension..."
cd /srv/app/src_extensions/ckanext-aemet
pip install -e . --quiet

# Initialize CKAN database if needed
echo "Initializing CKAN database..."
ckan -c /etc/ckan/production.ini db init || echo "Database already initialized"

# Set up DataStore permissions
echo "Setting up DataStore permissions..."
ckan -c /etc/ckan/production.ini datastore set-permissions > /tmp/datastore_perms.sql || true
if [ -f /tmp/datastore_perms.sql ]; then
  python3 -c "import psycopg2; conn = psycopg2.connect('postgresql://ckan:ckan@db/datastore'); cur = conn.cursor(); cur.execute(open('/tmp/datastore_perms.sql').read()); conn.commit()" || echo "DataStore permissions already set"
fi

# Start CKAN
echo "Starting CKAN on http://0.0.0.0:5000..."
exec ckan -c /etc/ckan/production.ini run -H 0.0.0.0
