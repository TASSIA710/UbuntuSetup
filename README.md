
# Ubuntu Setup
Small bash script that will setup a factory-new Ubuntu 18.04 server with base packages for you.



## Supports
- `Linux / Ubuntu / 18.04`



# Running
> To run the installer, simply type `bash <(curl https://cdn.tassilo.tk/generic/ubuntu_setup/install.sh)`.\
> **Note:** This script requires you to be a root user.



## Configuration

> **`CFG_HOSTNAME [REQUIRED]`**\
> This is the hostname of your server. All packages will be configured to this hostname. Make sure it is correct!

> **`CFG_BRANDNAME [REQUIRED]`**\
> The brand name of your server, e.g. your own name, your companys name or just some random name.

> **`CFG_SELF_EMAIL [REQUIRED]`**\
> Your email address.

> **`CFG_SELF_USERNAME [REQUIRED]`**\
> Your desired username to login.

> **`CFG_SELF_FIRSTNAME [REQUIRED]`**\
> Your first name.

> **`CFG_SELF_LASTNAME [REQUIRED]`**\
> Your last name (can just be a single letter, but may not be empty!)

> **`CFG_SELF_PASSWORD [REQUIRED]`**\
> The password you want to use to login on your websites, e.g. the Pterodactyl panel.

> **`CFG_PMA_VERSION`**\
> The latest version of phpMyAdmin. This is used to extract PMA properly.\
> *Default: `5.0.2`*

> **`CFG_DB_PASSWORD`**\
> The password of the `admin` database account.\
> *Default: `password`*

> **`CFG_PANEL_DB_PASSWORD`**\
> The password for the `pterodactyl` database account.\
> *Default: `password`*

> **`CFG_PANEL_MEMORY`**\
> How much memory should the main node have? (in MB)\
> *Default: `2000 MB (2 GB)`*

> **`CFG_PANEL_MEMORY_OA`**\
> How much memory over-allocation should the main node have? (in %)\
> *Default: `-1`*

> **`CFG_PANEL_DISK`**\
> How much disk space should the main node have? (in MB)\
> *Default: `10000 MB (10 GB)`*

> **`CFG_PANEL_DISK_OA`**\
> How much disk space over-allocation should the main node have? (in %)\
> *Default: `-1`*

> **`CFG_PANEL_UPLOAD_LIMIT`**\
> The filesize limit for uploading files via the web file manage. (in MB)\
> *Default: `100 MB`*

> **`CFG_PANEL_SECRET`**\
> The panel's secret. This should be as random as possible.\
> *Default: `3uCx27kn4vjgGIBUtjBLehSySPtGNfYGlJZM`*

> **`CFG_PANEL_PORT_LISTEN`**\
> This is the port the Panel uses to speak with the Daemon.\
> *Default: `4000`*

> **`CFG_PANEL_PORT_SFTP`**\
> This is the port Pterodactyl will use to setup SFTP.\
> *Default: `2022`*

> **`CFG_INSTALL_GITLAB`**\
> Whether GitLab should be installed or not. (Experimental)\
> *Default: `false`*



## Installed websites

> **Note:** `example.com` is whatever you defined as `CFG_HOSTNAME`.

> **`example.com`**\
> This is your main website. It will show the progress during installation so you can keep track of what the installer is doing currently. After that, this page will display the contents of `/var/www/html`.

> **`pma.example.com`**\
> This is your phpMyAdmin access point aka where you can manage your databases.\
> *Username: `admin`*\
> *Password: `$CFG_DB_PASSWORD`*

> **`panel.example.com`**\
> This is your Pterodactyl panel. It should already have a node setup.\
> *Username: `$CFG_SELF_USERNAME`*\
> *Password: `$CFG_SELF_PASSWORD`*



## Installed packages
- `tar`
- `unzip`
- `apache2`
- `php7.2`
- `mariadb-server`
- `composer`
- `curl`
- `docker`
- `dos2unix`
- `gcc`
- `g++`
- `make`
- `nmap`
- `nodejs`
- `redis-server`
- `webhook`
- `postfix`
- `pterodactyl-daemon`



## Installed PHP modifications
- `php7.2-cli`
- `php7.2-gd`
- `php7.2-mysqlnd`
- `php7.2-mysqli`
- `php7.2-pdo`
- `php7.2-mbstring`
- `php7.2-tokenizer`
- `php7.2-bcmath`
- `php7.2-xml`
- `php7.2-fpm`
- `php7.2-curl`
- `php7.2-zip`
