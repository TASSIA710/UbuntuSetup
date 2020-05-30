#!/bin/bash

# Auto-Setup Script
# Ubuntu 18.04.3 LTS
# by Tassilo





# -- Configuration: START
CFG_HOSTNAME="localhost"
CFG_BRANDNAME="Tassilo"

CFG_SELF_EMAIL="tassia710@gmail.com"
CFG_SELF_USERNAME="TASSIA"
CFG_SELF_FIRSTNAME="Tassilo"
CFG_SELF_LASTNAME="L"
CFG_SELF_PASSWORD="password"

CFG_PMA_VERSION="5.0.2"

CFG_DB_PASSWORD="password"

CFG_PANEL_DB_PASSWORD="password"
CFG_PANEL_MEMORY="2000"
CFG_PANEL_MEMORY_OA="-1"
CFG_PANEL_DISK="10000"
CFG_PANEL_DISK_OA="-1"
CFG_PANEL_UPLOAD_LIMIT="100"
CFG_PANEL_SECRET="3uCx27kn4vjgGIBUtjBLehSySPtGNfYGlJZM"
CFG_PANEL_PORT_LISTEN="4000"
CFG_PANEL_PORT_SFTP="2022"

CFG_INSTALL_GITLAB="false"
# -- Configuration: END





# -- Functions: START
log()
{
	printf "$1\n" >> /var/www/html/log.txt
	echo "$1"
}

set_todo()
{
	if [ -z $2 ]; then
		ID="b$1"
	else
		ID="s$1_$2"
	fi
	sed -i "s/^$ID=.*$/$ID=false/g" /var/www/html/progress.txt
	printf "Status Change: $ID -> TODO\n" >> /var/www/html/log_status.txt
}

set_wip()
{
	if [ -z $2 ]; then
		ID="b$1"
	else
		ID="s$1_$2"
	fi
	sed -i "s/^$ID=.*$/$ID=wip/g" /var/www/html/progress.txt
	printf "Status Change: $ID -> WIP\n" >> /var/www/html/log_status.txt
}

set_done()
{
	if [ -z $2 ]; then
		ID="b$1"
	else
		ID="s$1_$2"
	fi
	sed -i "s/^$ID=.*$/$ID=true/g" /var/www/html/progress.txt
	printf "Status Change: $ID -> DONE\n" >> /var/www/html/log_status.txt
}
# -- Functions: END





# -- Cleanup: START
mkdir -p /var >> /dev/null 2>&1
mkdir -p /var/www >> /dev/null 2>&1
mkdir -p /var/www/html >> /dev/null 2>&1

rm /var/www/html/log.txt >> /dev/null 2>&1
rm /var/www/html/log_status.txt >> /dev/null 2>&1
rm /var/www/html/maintenance.php >> /dev/null 2>&1
rm /var/www/html/output.txt >> /dev/null 2>&1
rm /var/www/html/progress.txt >> /dev/null 2>&1

touch /var/www/html/log.txt >> /dev/null 2>&1
touch /var/www/html/log_status.txt >> /dev/null 2>&1
touch /var/www/html/output.txt >> /dev/null 2>&1
# -- Cleanup: END





# -- Initialize Script: START
log "Initializing script..."

log "| Switching directory to /var/www/html..."
cd /var/www/html >> /var/www/html/output.txt 2>&1

log "| Fetching https://cdn.tassilo.tk/generic/ubuntu_setup/maintenance.php.txt"
wget -v https://cdn.tassilo.tk/generic/ubuntu_setup/maintenance.php.txt >> /var/www/html/output.txt 2>&1
mv maintenance.php.txt maintenance.php >> /var/www/html/output.txt 2>&1

log "| Fetching https://cdn.tassilo.tk/generic/ubuntu_setup/progress.txt"
wget -v https://cdn.tassilo.tk/generic/ubuntu_setup/progress.txt >> /var/www/html/output.txt 2>&1
# -- Initialize Script: END





# -- Receive Server: START
set_wip "001"
set_done "001"
# -- Receive Server: END





# -- Core Setup: START
set_wip "002"
log "Setting up core..."


# Install tar
set_wip "002" "001"
log "| Installing tar..."
apt install -y tar >> /var/www/html/output.txt 2>&1
set_done "002" "001"


# Install unzip
set_wip "002" "002"
log "| Installing unzip..."
apt install -y unzip >> /var/www/html/output.txt 2>&1
set_done "002" "002"


set_done "002"
# -- Core Setup: END





# -- Apache2: START
set_wip "003"
log "Installing Apache2..."


# Install Apache2
set_wip "003" "001"
log "| Installing Apache2..."
apt install -y apache2 >> /var/www/html/output.txt 2>&1
set_done "003" "001"


# Create index.html
set_wip "003" "007"
log "| Creating index.html"
cd /var/www/html/ >> /var/www/html/output.txt 2>&1
printf "" > index.html
printf "<!DOCTYPE html>" >> index.html
printf "<html>" >> index.html
printf "<head>" >> index.html
printf "<title>Maintenance</title>" >> index.html
printf "</head>" >> index.html
printf "<body>" >> index.html
printf "<h1>Maintenance</h1>" >> index.html
printf "<h5>There is currently a maintenance in progress.</h5>" >> index.html
printf "</body>" >> index.html
printf "</html>" >> index.html
set_done "003" "007"


# Remove default-ssl.conf
set_wip "003" "002"
log "| Removing default-ssl.conf"
rm /etc/apache2/sites-available/default-ssl.conf >> /var/www/html/output.txt 2>&1
set_done "003" "002"


# Enable "rewrite" modification
set_wip "003" "003"
log "| Enabling 'rewrite' modification..."
a2enmod rewrite >> /var/www/html/output.txt 2>&1
set_done "003" "003"


# Enable "proxy" modification
set_wip "003" "004"
log "| Enabling 'proxy' modification..."
a2enmod proxy >> /var/www/html/output.txt 2>&1
set_done "003" "004"


# Enable "proxy_http" modification
set_wip "003" "005"
log "| Enabling 'proxy_http' modification..."
a2enmod proxy_http >> /var/www/html/output.txt 2>&1
set_done "003" "005"


# Restart Apache2
set_wip "003" "006"
log "| Restarting Apache2..."
systemctl restart apache2 >> /var/www/html/output.txt 2>&1
set_done "003" "006"


set_done "003"
# -- Apache2: END





# -- PHP: START
set_wip "004"
log "Installing PHP..."


# Install PHP 7.2
set_wip "004" "001"
log "| Installing php7.2"
apt install -y php7.2 >> /var/www/html/output.txt 2>&1
set_done "004" "001"


# Install LibApache2 PHP 7.2 Modification
set_wip "004" "002"
log "| Installing LibApache2 PHP 7.2 Modification..."
apt install -y libapache2-mod-php7.2 >> /var/www/html/output.txt 2>&1
set_done "004" "002"


# Create index.php
set_wip "004" "017"
log "| Creating index.php"
cd /var/www/html/ >> /var/www/html/output.txt 2>&1
rm index.html >> /var/www/html/output.txt 2>&1
printf "" > index.php
printf "<?php\n" >> index.php
printf "include('maintenance.php');\n" >> index.php
printf "?>" >> index.php
set_done "004" "017"


# Install PHP 7.2 - cli
set_wip "004" "003"
log "| Installing php7.2-cli"
apt install -y php7.2-cli >> /var/www/html/output.txt 2>&1
set_done "004" "003"


# Install PHP 7.2 - gd
set_wip "004" "004"
log "| Installing php7.2-gd"
apt install -y php7.2-gd >> /var/www/html/output.txt 2>&1
set_done "004" "004"


# Install PHP 7.2 - mysqlnd
set_wip "004" "005"
log "| Installing php7.2-mysqlnd"
apt install -y php7.2-mysqlnd >> /var/www/html/output.txt 2>&1
set_done "004" "005"


# Install PHP 7.2 - mysqli
set_wip "004" "006"
log "| Installing php7.2-mysqli"
apt install -y php7.2-mysqli >> /var/www/html/output.txt 2>&1
set_done "004" "006"


# Install PHP 7.2 - pdo
set_wip "004" "007"
log "| Installing php7.2-pdo"
apt install -y php7.2-pdo >> /var/www/html/output.txt 2>&1
set_done "004" "007"


# Install PHP 7.2 - mbstring
set_wip "004" "008"
log "| Installing php7.2-mbstring"
apt install -y php7.2-mbstring >> /var/www/html/output.txt 2>&1
set_done "004" "008"


# Install PHP 7.2 - tokenizer
set_wip "004" "009"
log "| Installing php7.2-tokenizer"
apt install -y php7.2-tokenizer >> /var/www/html/output.txt 2>&1
set_done "004" "009"


# Install PHP 7.2 - bcmath
set_wip "004" "010"
log "| Installing php7.2-bcmath"
apt install -y php7.2-bcmath >> /var/www/html/output.txt 2>&1
set_done "004" "010"


# Install PHP 7.2 - xml
set_wip "004" "011"
log "| Installing php7.2-xml"
apt install -y php7.2-xml >> /var/www/html/output.txt 2>&1
set_done "004" "011"


# Install PHP 7.2 - fpm
set_wip "004" "012"
log "| Installing php7.2-fpm"
apt install -y php7.2-fpm >> /var/www/html/output.txt 2>&1
set_done "004" "012"


# Install PHP 7.2 - curl
set_wip "004" "013"
log "| Installing php7.2-curl"
apt install -y php7.2-curl >> /var/www/html/output.txt 2>&1
set_done "004" "013"


# Install PHP 7.2 - zip
set_wip "004" "014"
log "| Installing php7.2-zip"
apt install -y php7.2-zip >> /var/www/html/output.txt 2>&1
set_done "004" "014"


# Enable PHP modifications
set_wip "004" "015"
log "| Enabling PHP modifications..."
phpenmod calendar >> /var/www/html/output.txt 2>&1
phpenmod ctype >> /var/www/html/output.txt 2>&1
phpenmod exif >> /var/www/html/output.txt 2>&1
phpenmod fileinfo >> /var/www/html/output.txt 2>&1
phpenmod ftp >> /var/www/html/output.txt 2>&1
phpenmod gettext >> /var/www/html/output.txt 2>&1
phpenmod iconv >> /var/www/html/output.txt 2>&1
phpenmod json >> /var/www/html/output.txt 2>&1
phpenmod mysqli >> /var/www/html/output.txt 2>&1
phpenmod mysqlnd >> /var/www/html/output.txt 2>&1
phpenmod opcache >> /var/www/html/output.txt 2>&1
phpenmod pdo >> /var/www/html/output.txt 2>&1
phpenmod pdo_mysql >> /var/www/html/output.txt 2>&1
phpenmod phar >> /var/www/html/output.txt 2>&1
phpenmod posix >> /var/www/html/output.txt 2>&1
phpenmod readline >> /var/www/html/output.txt 2>&1
phpenmod shmop >> /var/www/html/output.txt 2>&1
phpenmod sockets >> /var/www/html/output.txt 2>&1
phpenmod sysvmsg >> /var/www/html/output.txt 2>&1
phpenmod sysvsem >> /var/www/html/output.txt 2>&1
phpenmod sysvshm >> /var/www/html/output.txt 2>&1
phpenmod tokenizer >> /var/www/html/output.txt 2>&1
set_done "004" "015"


# Restart Apache2
set_wip "004" "016"
log "| Restarting Apache2..."
systemctl restart apache2 >> /var/www/html/output.txt 2>&1
set_done "004" "016"


set_done "004"
# -- PHP: END





# -- MariaDB: 
set_wip "005"
log "Installing MariaDB..."


# Install MariaDB (Server)
set_wip "005" "001"
log "| Installing MariaDB (Server)..."
apt install -y mariadb-server >> /var/www/html/output.txt 2>&1
set_done "005" "001"


# Create "global" database
set_wip "005" "002"
log "| Creating 'global' database..."
mysql -u root -p[] -e "DROP DATABASE global;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "CREATE DATABASE global;" >> /var/www/html/output.txt 2>&1
set_done "005" "002"


# Create "admin"@"%" account
set_wip "005" "003"
log "| Creating 'admin'@'%' account..."
mysql -u root -p[] -e "DROP USER 'admin'@'%';" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$CFG_DB_PASSWORD';" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;" >> /var/www/html/output.txt 2>&1
set_done "005" "003"


# Flush privileges
set_wip "005" "004"
log "| Flushing privileges..."
mysql -u root -p[] -e "FLUSH PRIVILEGES;" >> /var/www/html/output.txt 2>&1
set_done "005" "004"


set_done "005"
# -- MariaDB: END





# -- phpMyAdmin: START
set_wip "006"
log "Installing phpMyAdmin..."


# Download phpMyAdmin-latest-all-languages.zip
set_wip "006" "001"
log "| Downloading phpMyAdmin-latest-all-languages.zip"
cd /var/www/ >> /var/www/html/output.txt 2>&1
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip >> /var/www/html/output.txt 2>&1
set_done "006" "001"


# Extract phpMyAdmin-latest-all-languages.zip
set_wip "006" "002"
log "| Extracting phpMyAdmin-latest-all-languages.zip"
unzip phpMyAdmin-latest-all-languages.zip >> /var/www/html/output.txt 2>&1
set_done "006" "002"


# Cleanup temporary files
set_wip "006" "003"
log "| Cleaning up temporary files..."
rm -r phpmyadmin >> /var/www/html/output.txt 2>&1
mv phpMyAdmin-$CFG_PMA_VERSION-all-languages phpmyadmin >> /var/www/html/output.txt 2>&1
rm phpMyAdmin-latest-all-languages.zip >> /var/www/html/output.txt 2>&1
set_done "006" "003"


# Create pma.? host
set_wip "006" "004"
log "| Creating pma.? host..."
cd /etc/apache2/sites-available/ >> /var/www/html/output.txt 2>&1
printf "" > 001-phpmyadmin.conf
printf "<VirtualHost *:80>\n" >> 001-phpmyadmin.conf
printf "\tServerName pma.$CFG_HOSTNAME\n" >> 001-phpmyadmin.conf
printf "\tDocumentRoot /var/www/phpmyadmin\n" >> 001-phpmyadmin.conf
printf "\tErrorLog \${APACHE_LOG_DIR}/error.log\n" >> 001-phpmyadmin.conf
printf "\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n" >> 001-phpmyadmin.conf
printf "</VirtualHost>" >> 001-phpmyadmin.conf
set_done "006" "004"


# Enable host & restart Apache2
set_wip "006" "005"
log "| Enabling host & restarting Apache2..."
a2ensite 001-phpmyadmin >> /var/www/html/output.txt 2>&1
systemctl restart apache2 >> /var/www/html/output.txt 2>&1
set_done "006" "005"


# Set file modification & ownerships
set_wip "006" "006"
log "| Setting file modification & ownerships..."
chmod -R 755 /var/www/phpmyadmin >> /var/www/html/output.txt 2>&1
chown -R www-data:www-data /var/www/phpmyadmin >> /var/www/html/output.txt 2>&1
set_done "006" "006"


set_done "006"
# -- phpMyAdmin: END





# -- Utility & Dependencies: START
set_wip "007"
log "Installing utility packages & dependencies..."


# Redis Server
set_wip "007" "001"
log "| Installing Redis server..."
add-apt-repository -y ppa:chris-lea/redis-server >> /var/www/html/output.txt 2>&1
apt install -y redis-server >> /var/www/html/output.txt 2>&1
systemctl enable --now redis-server >> /var/www/html/output.txt 2>&1
set_done "007" "001"


# Docker
set_wip "007" "002"
log "| Installing Docker..."
curl -sSL https://get.docker.com/ | CHANNEL=stable bash >> /var/www/html/output.txt 2>&1
systemctl enable docker >> /var/www/html/output.txt 2>&1
set_done "007" "002"


# NodeJS
set_wip "007" "003"
log "| Installing NodeJS..."
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - >> /var/www/html/output.txt 2>&1
apt install -y nodejs >> /var/www/html/output.txt 2>&1
set_done "007" "003"


# Git
set_wip "007" "004"
log "| Installing Git client..."
apt install -y git >> /var/www/html/output.txt 2>&1
set_done "007" "004"


# Composer
set_wip "007" "005"
log "| Installing Composer..."
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer >> /var/www/html/output.txt 2>&1
set_done "007" "005"


# Install make
set_wip "007" "006"
log "| Installing Make..."
apt install -y make >> /var/www/html/output.txt 2>&1
set_done "007" "006"


# Install gcc
set_wip "007" "007"
log "| Installing GCC..."
apt install -y gcc >> /var/www/html/output.txt 2>&1
set_done "007" "007"


# Install g++
set_wip "007" "008"
log "| Installing G++..."
apt install -y g++ >> /var/www/html/output.txt 2>&1
set_done "007" "008"


# Install dos2unix
set_wip "007" "009"
log "| Installing Dos2Unix..."
apt install -y dos2unix >> /var/www/html/output.txt 2>&1
set_done "007" "009"


# Install nmap
set_wip "007" "010"
log "| Installing NMap..."
apt install -y nmap >> /var/www/html/output.txt 2>&1
set_done "007" "010"


# Install curl
set_wip "007" "011"
log "| Installing Curl..."
apt install -y curl >> /var/www/html/output.txt 2>&1
set_done "007" "011"


# Install webhook
set_wip "007" "012"
log "| Installing Webhook..."
apt install -y webhook >> /var/www/html/output.txt 2>&1
set_done "007" "012"


set_done "007"
# -- Utility & Dependencies: END





# -- SMTP Server: START
set_wip "008"
log "Installing SMTP Server..."


# Install Postfix
set_wip "008" "001"
log "| Installing Postfix..."
debconf-set-selections <<< "postfix postfix/mailname string $CFG_HOSTNAME"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt install -y postfix >> /var/www/html/output.txt 2>&1
set_done "008" "001"


# Restart Postfix
set_wip "008" "002"
log "| Restarting Postfix..."
systemctl restart postfix >> /var/www/html/output.txt 2>&1
set_done "008" "002"


set_done "008"
# -- SMTP Server: END





# -- Pterodactyl Panel: START
set_wip "011"
log "Installing Pterodactyl Panel..."


# Dependencies (ppa:ondrej/php, ppa:chris-lea/redis-server, universe)
set_wip "011" "001"
log "| Installing dependencies (software-properties-common, ppa:ondrej/php, ppa:chris-lea/redis-server, universe)..."
apt install -y software-properties-common >> /var/www/html/output.txt 2>&1
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php >> /var/www/html/output.txt 2>&1
add-apt-repository -y ppa:chris-lea/redis-server >> /var/www/html/output.txt 2>&1
apt-add-repository -y universe >> /var/www/html/output.txt 2>&1
apt update -y >> /var/www/html/output.txt 2>&1
set_done "011" "001"


# Download files
set_wip "011" "002"
log "| Downloading files..."
mkdir -p /var/www/pterodactyl >> /var/www/html/output.txt 2>&1
cd /var/www/pterodactyl >> /var/www/html/output.txt 2>&1
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/download/v0.7.17/panel.tar.gz >> /var/www/html/output.txt 2>&1
tar --strip-components=1 -xzvf panel.tar.gz >> /var/www/html/output.txt 2>&1
chmod -R 755 storage/* bootstrap/cache/ >> /var/www/html/output.txt 2>&1
set_done "011" "002"


# Install Panel (Composer dependencies, key generation, etc.)
set_wip "011" "003"
log "| Installing Panel (Composer dependencies, key generation, etc.)..."
cp .env.example .env >> /var/www/html/output.txt 2>&1
composer install --no-dev --optimize-autoloader >> /var/www/html/output.txt 2>&1
php artisan key:generate --force >> /var/www/html/output.txt 2>&1
set_done "011" "003"


# Create database accounts
set_wip "011" "012"
log "| Creating database accounts..."
mysql -u root -p[] -e "DROP USER 'pterodactyl'@'127.0.0.1';" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "DROP DATABASE panel;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY '$CFG_PANEL_DB_PASSWORD';" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "CREATE DATABASE panel;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] -e "FLUSH PRIVILEGES;" >> /var/www/html/output.txt 2>&1
set_done "011" "012"


# Configure Pterodactyl Panel
set_wip "011" "004"
log "| Configuring Pterodactyl panel..."
php artisan p:environment:setup
# php artisan p:environment:setup --author=no-reply@$CFG_HOSTNAME --url=http://panel.$CFG_HOSTNAME --timezone=UTC --cache=redis --session=redis --queue=redis --redis-host=localhost --redis-pass="" --redis-port=6379 --no-interaction -vvv >> /var/www/html/output.txt 2>&1
php artisan p:environment:database --host=127.0.0.1 --port=3306 --database=panel --username=pterodactyl --password=$CFG_PANEL_DB_PASSWORD --no-interaction -vvv >> /var/www/html/output.txt 2>&1
php artisan p:environment:mail --driver=mail --email=no-reply@$CFG_HOSTNAME --from=$CFG_BRANDNAME --encryption=tls --no-interaction -vvv >> /var/www/html/output.txt 2>&1
set_done "011" "004"


# Populate database
set_wip "011" "005"
log "| Populating database..."
php artisan migrate --seed --no-interaction --force >> /var/www/html/output.txt 2>&1
set_done "011" "005"


# Create admin user
set_wip "011" "006"
log "| Creating admin user..."
php artisan p:user:make --admin=1 --email=$CFG_SELF_EMAIL --username=$CFG_SELF_USERNAME --name-first=$CFG_SELF_FIRSTNAME --name-last=$CFG_SELF_LASTNAME --password=$CFG_SELF_PASSWORD --no-interaction -vvv >> /var/www/html/output.txt 2>&1
set_done "011" "006"


# Manage permissions
set_wip "011" "007"
log "| Managing permissions..."
chown -R www-data:www-data /var/www/pterodactyl >> /var/www/html/output.txt 2>&1
set_done "011" "007"


# Configure Crontab
set_wip "011" "008"
log "| Configuring Crontab..."
(crontab -l 2>/dev/null; echo "* * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1") | crontab -
set_done "011" "008"


# Create pteroq.service
set_wip "011" "009"
log "| Creating pteroq.service"
printf "" > /etc/systemd/system/pteroq.service
printf "# Pterodactyl Queue Worker File\n" >> /etc/systemd/system/pteroq.service
printf "# ----------------------------------\n" >> /etc/systemd/system/pteroq.service
printf "\n" >> /etc/systemd/system/pteroq.service
printf "[Unit]\n" >> /etc/systemd/system/pteroq.service
printf "Description=Pterodactyl Queue Worker\n" >> /etc/systemd/system/pteroq.service
printf "After=redis-server.service\n" >> /etc/systemd/system/pteroq.service
printf "\n" >> /etc/systemd/system/pteroq.service
printf "[Service]\n" >> /etc/systemd/system/pteroq.service
printf "# On some systems the user and group might be different.\n" >> /etc/systemd/system/pteroq.service
printf "# Some systems use 'apache' or 'nginx' as the user and group.\n" >> /etc/systemd/system/pteroq.service
printf "User=www-data\n" >> /etc/systemd/system/pteroq.service
printf "Group=www-data\n" >> /etc/systemd/system/pteroq.service
printf "Restart=always\n" >> /etc/systemd/system/pteroq.service
printf "ExecStart=/usr/bin/php /var/www/pterodactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3\n" >> /etc/systemd/system/pteroq.service
printf "\n" >> /etc/systemd/system/pteroq.service
printf "[Install]\n" >> /etc/systemd/system/pteroq.service
printf "WantedBy=multi-user.target" >> /etc/systemd/system/pteroq.service
set_done "011" "009"


# Enable Pterodactyl Panel
set_wip "011" "010"
log "| Enabling Pterodactyl panel..."
systemctl enable --now pteroq.service >> /var/www/html/output.txt 2>&1
set_done "011" "010"


# Create panel.localhost host
set_wip "011" "011"
log "| Creating panel.$CFG_HOSTNAME host..."
cd /etc/apache2/sites-available/ >> /var/www/html/output.txt 2>&1
printf "" > 003-panel.conf
printf "<VirtualHost *:80>\n" >> 003-panel.conf
printf "\tServerName panel.$CFG_HOSTNAME\n" >> 003-panel.conf
printf "\tDocumentRoot /var/www/pterodactyl/public\n" >> 003-panel.conf
printf "\tAllowEncodedSlashes On\n" >> 003-panel.conf
printf "\tphp_value upload_max_filesize 100M\n" >> 003-panel.conf
printf "\tphp_value post_max_size 100M\n" >> 003-panel.conf
printf "\tErrorLog \${APACHE_LOG_DIR}/error.log\n" >> 003-panel.conf
printf "\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n" >> 003-panel.conf
printf "\t<Directory /var/www/pterodactyl/public>\n" >> 003-panel.conf
printf "\t\tAllowOverride all\n" >> 003-panel.conf
printf "\t</Directory>\n" >> 003-panel.conf
printf "</VirtualHost>" >> 003-panel.conf
a2ensite 003-panel >> /var/www/html/output.txt 2>&1
systemctl restart apache2 >> /var/www/html/output.txt 2>&1
set_done "011" "011"


set_done "011"
# -- Pterodactyl Panel: END





# -- Pterodactyl Daemon: START
set_wip "012"
log "Installing Pterodactyl Daemon..."


# Enable Swap
set_wip "012" "001"
log "| Enabling Swap..."
# set_done "012" "001"


# Download Daemon Software
set_wip "012" "002"
log "| Downloading Daemon software..."
mkdir -p /srv/daemon /srv/daemon-data >> /var/www/html/output.txt 2>&1
cd /srv/daemon >> /var/www/html/output.txt 2>&1
(curl -L https://github.com/pterodactyl/daemon/releases/download/v0.6.13/daemon.tar.gz | tar --strip-components=1 -xzv) >> /var/www/html/output.txt 2>&1
set_done "012" "002"


# Install Daemon Software
set_wip "012" "003"
log "| Installing Daemon software..."
npm install --only=production --no-audit --unsafe-perm >> /var/www/html/output.txt 2>&1
set_done "012" "003"


# Create Node
set_wip "012" "007"
log "| Creating Node..."
mysql -u root -p[] panel -e "TRUNCATE \`locations\`;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] panel -e "INSERT INTO \`locations\` (\`id\`, \`short\`, \`long\`, \`created_at\`, \`updated_at\`) VALUES ('1', 'localhost', 'localhost', NOW(), NOW());" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] panel -e "TRUNCATE \`nodes\`;" >> /var/www/html/output.txt 2>&1
mysql -u root -p[] panel -e "INSERT INTO \`nodes\` (\`id\`, \`public\`, \`name\`, \`description\`, \`location_id\`, \`fqdn\`, \`scheme\`, \`behind_proxy\`, \`maintenance_mode\`, \`memory\`, \`memory_overallocate\`, \`disk\`, \`disk_overallocate\`, \`upload_size\`, \`daemonSecret\`, \`daemonListen\`, \`daemonSFTP\`, \`daemonBase\`, \`created_at\`, \`updated_at\`) VALUES (1, 1, 'Daemon', 'Daemon', 1, 'panel.$CFG_HOSTNAME', 'http', 0, 0, $CFG_PANEL_MEMORY, $CFG_PANEL_MEMORY_OA, $CFG_PANEL_DISK, $CFG_PANEL_DISK_OA, $CFG_PANEL_UPLOAD_LIMIT, '$CFG_PANEL_SECRET', $CFG_PANEL_PORT_LISTEN, $CFG_PANEL_PORT_SFTP, '/srv/daemon-data', NOW(), NOW());" >> /var/www/html/output.txt 2>&1
set_done "012" "007"


# Configure Daemon
set_wip "012" "004"
log "| Configuring Daemon..."
printf "" > /srv/daemon/config/core.json
printf "{" >> /srv/daemon/config/core.json
printf "	\"web\": {" >> /srv/daemon/config/core.json
printf "		\"host\": \"0.0.0.0\"," >> /srv/daemon/config/core.json
printf "		\"listen\": $CFG_PANEL_PORT_LISTEN," >> /srv/daemon/config/core.json
printf "		\"ssl\": {" >> /srv/daemon/config/core.json
printf "			\"enabled\": false," >> /srv/daemon/config/core.json
printf "			\"certificate\": \"/etc/letsencrypt/live/panel.$CFG_HOSTNAME/fullchain.pem\"," >> /srv/daemon/config/core.json
printf "			\"key\": \"/etc/letsencrypt/live/panel.$CFG_HOSTNAME/privkey.pem\"" >> /srv/daemon/config/core.json
printf "		}" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"docker\": {" >> /srv/daemon/config/core.json
printf "		\"container\": {" >> /srv/daemon/config/core.json
printf "			\"user\": null" >> /srv/daemon/config/core.json
printf "		}," >> /srv/daemon/config/core.json
printf "		\"network\": {" >> /srv/daemon/config/core.json
printf "			\"name\": \"pterodactyl_nw\"" >> /srv/daemon/config/core.json
printf "		}," >> /srv/daemon/config/core.json
printf "		\"socket\": \"/var/run/docker.sock\"," >> /srv/daemon/config/core.json
printf "		\"autoupdate_images\": true" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"filesystem\": {" >> /srv/daemon/config/core.json
printf "		\"server_logs\": \"/tmp/pterodactyl\"" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"internals\": {" >> /srv/daemon/config/core.json
printf "		\"disk_use_seconds\": 30," >> /srv/daemon/config/core.json
printf "		\"set_permissions_on_boot\": true," >> /srv/daemon/config/core.json
printf "		\"throttle\": {" >> /srv/daemon/config/core.json
printf "			\"enabled\": true," >> /srv/daemon/config/core.json
printf "			\"kill_at_count\": 5," >> /srv/daemon/config/core.json
printf "			\"decay\": 10," >> /srv/daemon/config/core.json
printf "			\"lines\": 1000," >> /srv/daemon/config/core.json
printf "			\"check_interval_ms\": 100" >> /srv/daemon/config/core.json
printf "		}" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"sftp\": {" >> /srv/daemon/config/core.json
printf "		\"path\": \"/srv/daemon-data\"," >> /srv/daemon/config/core.json
printf "		\"ip\": \"0.0.0.0\"," >> /srv/daemon/config/core.json
printf "		\"port\": $CFG_PANEL_PORT_SFTP," >> /srv/daemon/config/core.json
printf "		\"keypair\": {" >> /srv/daemon/config/core.json
printf "			\"bits\": 2048," >> /srv/daemon/config/core.json
printf "			\"e\": 65537" >> /srv/daemon/config/core.json
printf "		}" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"logger\": {" >> /srv/daemon/config/core.json
printf "		\"path\": \"logs/\"," >> /srv/daemon/config/core.json
printf "		\"src\": false," >> /srv/daemon/config/core.json
printf "		\"level\": \"info\"," >> /srv/daemon/config/core.json
printf "		\"period\": \"1d\"," >> /srv/daemon/config/core.json
printf "		\"count\": 3" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"remote\": {" >> /srv/daemon/config/core.json
printf "		\"base\": \"http://panel.$CFG_HOSTNAME\"" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"uploads\": {" >> /srv/daemon/config/core.json
printf "		\"size_limit\": $CFG_PANEL_UPLOAD_LIMIT" >> /srv/daemon/config/core.json
printf "	}," >> /srv/daemon/config/core.json
printf "	\"keys\": [" >> /srv/daemon/config/core.json
printf "		\"$CFG_PANEL_SECRET\"" >> /srv/daemon/config/core.json
printf "	]" >> /srv/daemon/config/core.json
printf "}" >> /srv/daemon/config/core.json
set_done "012" "004"


# Create wings.service
set_wip "012" "005"
log "| Creating wings.service"
printf "" > /etc/systemd/system/wings.service
printf "[Unit]\n" >> /etc/systemd/system/wings.service
printf "Description=Pterodactyl Wings Daemon\n" >> /etc/systemd/system/wings.service
printf "After=docker.service\n" >> /etc/systemd/system/wings.service
printf "\n" >> /etc/systemd/system/wings.service
printf "[Service]\n" >> /etc/systemd/system/wings.service
printf "User=root\n" >> /etc/systemd/system/wings.service
printf "#Group=some_group\n" >> /etc/systemd/system/wings.service
printf "WorkingDirectory=/srv/daemon\n" >> /etc/systemd/system/wings.service
printf "LimitNOFILE=4096\n" >> /etc/systemd/system/wings.service
printf "PIDFile=/var/run/wings/daemon.pid\n" >> /etc/systemd/system/wings.service
printf "ExecStart=/usr/bin/node /srv/daemon/src/index.js\n" >> /etc/systemd/system/wings.service
printf "Restart=on-failure\n" >> /etc/systemd/system/wings.service
printf "StartLimitInterval=600\n" >> /etc/systemd/system/wings.service
printf "\n" >> /etc/systemd/system/wings.service
printf "[Install]\n" >> /etc/systemd/system/wings.service
printf "WantedBy=multi-user.target\n" >> /etc/systemd/system/wings.service
set_done "012" "005"


# Enable Pterodactyl Daemon
set_wip "012" "006"
log "| Enabling Pterodactyl Daemon..."
systemctl enable --now wings >> /var/www/html/output.txt 2>&1
systemctl restart wings >> /var/www/html/output.txt 2>&1
set_done "012" "006"


set_done "012"
# -- Pterodactyl Daemon: END





# -- GitLab Server: START
set_wip "010"
log "Installing GitLab server..."

if [ $CFG_INSTALL_GITLAB = "true" ]; then

	# Dependencies (curl, openssh-server, ca-certificates)
	set_wip "010" "001"
	log "| Installing Dependencies (curl, openssh-server, ca-certificates)..."
	apt install -y curl openssh-server ca-certificates >> /var/www/html/output.txt 2>&1
	set_done "010" "001"


	# Install GitLab package repository
	set_wip "010" "002"
	log "| Installing GitLab package repository..."
	(curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash) >> /var/www/html/output.txt 2>&1
	set_done "010" "002"


	# Install GitLab Community Edition
	set_wip "010" "003"
	log "| Installing GitLab Community Edition..."
	apt install -y gitlab-ce >> /var/www/html/output.txt 2>&1
	set_done "010" "003"


	# Configure GitLab
	set_wip "010" "004"
	log "| Configuring Gitlab..."
	sed -in "s/external_url 'http:\/\/gitlab.example.com'/external_url 'http:\/\/gitlab.$CFG_HOSTNAME:8080'/g" /etc/gitlab/gitlab.rb
	sed -in "s/# nginx\['enable'\] = true/nginx['enable'] = false/g" /etc/gitlab/gitlab.rb
	sed -in "s/# web_server\['external_users'\] = \[\]/web_server['external_users'] = \['www-data'\]/g" /etc/gitlab/gitlab.rb
	set_done "010" "004"


	# Add Apache user to GitLab user group
	set_wip "010" "005"
	log "| Adding Apache user to GitLab user group..."
	adduser www-data gitlab-www >> /var/www/html/output.txt 2>&1
	usermod -G gitlab-www www-data >> /var/www/html/output.txt 2>&1
	set_done "010" "005"


	# Create gitlab.localhost host
	set_wip "010" "006"
	log "| Creating gitlab.$CFG_HOSTNAME host..."
	cd /etc/apache2/sites-available/ >> /var/www/html/output.txt 2>&1
	printf "" > 002-gitlab.conf
	printf "<VirtualHost *:80>\n" >> 002-gitlab.conf
	printf "\tServerName gitlab.$CFG_HOSTNAME\n" >> 002-gitlab.conf
	printf "\tServerSignature Off\n" >> 002-gitlab.conf
	printf "\tProxyPreserveHost On\n" >> 002-gitlab.conf
	printf "\t<Location />\n" >> 002-gitlab.conf
	printf "\t\tOrder deny,allow\n" >> 002-gitlab.conf
	printf "\t\tAllow from all\n" >> 002-gitlab.conf
	printf "\t\tProxyPassReverse http://127.0.0.1:8080\n" >> 002-gitlab.conf
	printf "\t\tProxyPassReverse http://gitlab.$CFG_HOSTNAME/\n" >> 002-gitlab.conf
	printf "\t</Location>\n" >> 002-gitlab.conf
	printf "\tRewriteEngine on\n" >> 002-gitlab.conf
	printf "\tRewriteCond %%{DOCUMENT_ROOT}/%%{REQUEST_FILENAME} !-f\n" >> 002-gitlab.conf
	printf "\tRewriteRule .* http://127.0.0.1:8080%%{REQUEST_URI} [P,QSA]\n" >> 002-gitlab.conf
	printf "\t# needed for downloading attachments\n" >> 002-gitlab.conf
	printf "\tDocumentRoot /opt/gitlab/embedded/service/gitlab-rails/public\n" >> 002-gitlab.conf
	printf "</VirtualHost>" >> 002-gitlab.conf
	a2ensite 002-gitlab >> /var/www/html/output.txt 2>&1
	set_done "010" "006"


	# Restart Apache2
	set_wip "010" "007"
	log "| Restarting Apache2..."
	systemctl restart apache2 >> /var/www/html/output.txt 2>&1
	set_done "010" "007"


	# Reconfigure GitLab
	set_wip "010" "008"
	log "| Reconfiguring GitLab..."
	gitlab-ctl reconfigure >> /var/www/html/output.txt 2>&1
	set_done "010" "008"


	# Restart GitLab
	set_wip "010" "009"
	log "| Restarting GitLab..."
	gitlab-ctl restart >> /var/www/html/output.txt 2>&1
	set_done "010" "009"

else
	
	# Skip GitLab
	log "| Skipping GitLab..."

fi

set_done "010"
# -- GitLab Server: END





# -- Cleanup: START
set_wip "999"
log "Cleaning up..."


# Update packages
set_wip "999" "001"
log "| Updating packages..."
apt update -y >> /var/www/html/output.txt 2>&1
set_done "999" "001"


set_done "999"
# -- Cleanup: END





log "Done!"
