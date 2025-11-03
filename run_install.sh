#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Wait for the database to be ready
echo "Waiting for database to be ready..."
until sudo docker exec docker-db-1 mysqladmin ping -h "localhost" -u"root" -p"change-me" --silent; do
    sleep 1
done
echo "Database is ready."

# Run the MediaWiki installation script
echo "Running MediaWiki installation..."
sudo docker exec docker-mediawiki-1 php /var/www/html/maintenance/install.php \
    --dbname mediawiki \
    --dbserver db \
    --dbuser mediawiki \
    --dbpass mwpass \
    --pass 'a_very_secure_password_123!' \
    --server "http://localhost:8080" \
    --scriptpath "/" \
    "RQpedia" \
    "WikiSysop"

echo "MediaWiki installation complete."
