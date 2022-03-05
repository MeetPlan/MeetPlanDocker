mv default.conf.beforecert default.conf
sudo docker-compose up -d nginx-proxy
sudo docker-compose run --rm --entrypoint "certbot certonly --webroot --webroot-path=/var/www/html --email test@example.org --agree-tos --no-eff-email -d example.org" certbot
rm default.conf
mv default.conf.aftercert default.conf
sudo docker-compose down
