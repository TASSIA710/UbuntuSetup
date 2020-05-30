<?php

const CFG_HOSTNAME = 'localhost';

const CFG_PMA_VERSION = '5.0.2';



$tasks = [

	'001' => [
		'name' => 'Receive server (Ubuntu 18.04 LTS)',
		'sub' => []
	],



	'002' => [
		'name' => 'Core Setup',
		'sub' => [
			'001' => 'Install tar',
			'002' => 'Install unzip',
		]
	],



	'003' => [
		'name' => 'Apache2',
		'sub' => [
			'001' => 'Install Apache2',
			'007' => 'Create index.html',
			'002' => 'Remove default-ssl.conf',
			'003' => 'Enable "rewrite" modification',
			'004' => 'Enable "proxy" modification',
			'005' => 'Enable "proxy_http" modification',
			'006' => 'Restart Apache2',
		]
	],



	'004' => [
		'name' => 'PHP',
		'sub' => [
			'001' => 'Install PHP 7.2',
			'002' => 'Install LibApache2 PHP 7.2 Modification',
			'017' => 'Create index.php',
			'003' => 'Install PHP 7.2 - cli',
			'004' => 'Install PHP 7.2 - gd',
			'005' => 'Install PHP 7.2 - mysqlnd',
			'006' => 'Install PHP 7.2 - mysqli',
			'007' => 'Install PHP 7.2 - pdo',
			'008' => 'Install PHP 7.2 - mbstring',
			'009' => 'Install PHP 7.2 - tokenizer',
			'010' => 'Install PHP 7.2 - bcmath',
			'011' => 'Install PHP 7.2 - xml',
			'012' => 'Install PHP 7.2 - fpm',
			'013' => 'Install PHP 7.2 - curl',
			'014' => 'Install PHP 7.2 - zip',
			'015' => 'Enable PHP modifications',
			'016' => 'Restart Apache2',
		]
	],



	'005' => [
		'name' => 'MariaDB',
		'sub' => [
			'001' => 'Install MariaDB (Server)',
			'002' => 'Create "global" database',
			'003' => 'Create "admin"@"%" account',
			'004' => 'Flush privileges',
		]
	],



	'006' => [
		'name' => 'phpMyAdmin (' . CFG_PMA_VERSION . ')',
		'sub' => [
			'001' => 'Download phpMyAdmin-latest-all-languages.zip',
			'002' => 'Extract phpMyAdmin-latest-all-languages.zip',
			'003' => 'Cleanup temporary files',
			'004' => 'Create pma.' . CFG_HOSTNAME . ' host',
			'005' => 'Enable host & restart Apache2',
			'006' => 'Set file modification & ownerships',
		]
	],



	'007' => [
		'name' => 'Utility & Dependencies',
		'sub' => [
			'005' => 'Composer',
			'011' => 'Curl',
			'002' => 'Docker',
			'009' => 'Dos2Unix',
			'007' => 'GCC',
			'004' => 'Git Client',
			'008' => 'G++',
			'006' => 'Make',
			'010' => 'NMap',
			'003' => 'NodeJS',
			'001' => 'Redis Server',
			'012' => 'Webhook',
		],
	],



	'008' => [
		'name' => 'SMTP Server',
		'sub' => [
			'001' => 'Install Postfix',
			'002' => 'Restart Postfix',
		],
	],



	'011' => [
		'name' => 'Pterodactyl Panel',
		'sub' => [
			'001' => 'Dependencies (ppa:ondrej/php, ppa:chris-lea/redis-server, universe)',
			'002' => 'Download files',
			'003' => 'Install Panel (Composer dependencies, key generation, etc.)',
			'012' => 'Create database accounts',
			'004' => 'Configure Pterodactyl Panel',
			'005' => 'Populate database',
			'006' => 'Create admin user',
			'007' => 'Manage permissions',
			'008' => 'Configure Crontab',
			'009' => 'Create pteroq.service',
			'010' => 'Enable Pterodactyl Panel',
			'011' => 'Create panel.' . CFG_HOSTNAME . ' host',
		],
	],



	'012' => [
		'name' => 'Pterodactyl Daemon',
		'sub' => [
			'001' => 'Enable Swap',
			'002' => 'Download Daemon Software',
			'003' => 'Install Daemon Software',
			'007' => 'Create Node',
			'004' => 'Configure Daemon',
			'005' => 'Create wings.service',
			'006' => 'Enable Pterodactyl Daemon',
		],
	],



	'010' => [
		'name' => 'GitLab Server',
		'sub' => [
			'001' => 'Dependencies (openssh-server, ca-certificates)',
			'002' => 'Install GitLab package repository',
			'003' => 'Install GitLab Community Edition',
			'004' => 'Configure GitLab',
			'005' => 'Add Apache user to GitLab user group',
			'006' => 'Create gitlab.' . CFG_HOSTNAME . ' host',
			'007' => 'Restart Apache2',
			'008' => 'Reconfigure GitLab',
			'009' => 'Restart GitLab',
		],
	],



	'009' => [
		'name' => 'SSL Certificates',
		'sub' => [
			'001' => 'Add Certbot PPA',
			'002' => 'Install Certbot',
			'003' => 'Create SSL-Certificate for: ' . CFG_HOSTNAME,
			'004' => 'Create SSL-Certificate for: pma.' . CFG_HOSTNAME,
			'005' => 'Create SSL-Certificate for: gitlab.' . CFG_HOSTNAME,
		],
	],



	'999' => [
		'name' => 'Cleanup',
		'sub' => [
			'001' => 'Update packages',
		],
	],

];





$state = file_get_contents('progress.txt');
if (!$state) $state = '';

?>

<!DOCTYPE html>
<html>

	<head>

		<title>Maintenance</title>

		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" crossorigin="anonymous">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">

		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>

	</head>



	<body>

		<div class="main-container collapse<?= isset($_GET['show']) && $_GET['show'] == 'tasks' ? '' : ' show'; ?>" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">

			<span class="display-1">
				<small><i class="fas fa-tools mr-3"></i></small>
				<span>Maintenance</span>
			</span>

			<h4 class="mt-2 mb-5"><small class="text-muted">
				We are currently performing maintenance on our backend systems.<br>
				Visit our <a href="https://discord.gg/WDTKgbm">Discord</a> to stay updated!
			</small></h4>

			<a class="btn btn-primary" href=".main-container" data-toggle="collapse"><i class="fas fa-tasks mr-2"></i>View progress</a>

		</div>



		<div class="main-container collapse<?= isset($_GET['show']) && $_GET['show'] == 'tasks' ? ' show' : ''; ?>" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">

			<span class="display-1">
				<small><i class="fas fa-tasks mr-3"></i></small>
				<span>Current Progress</span>
			</span>

			<div class="border rounded my-5 p-3 text-muted" style="text-align: left; max-height: 50vh; overflow-y: auto;">
				<span>
					This checklist is aiming to give a rough outline of how far we are with setting up the new server.
					However, this process requires intensive testing, so please do not expect it to be up and running
					as soon as all tasks have been completed.
				</span>

				<?php
				foreach ($tasks as $id => $data) {
					echo '<div class="mt-2">';

					if (strpos($state, 'b' . $id . '=true') !== false) {
						echo '<strong class="mr-2 text-success">&#10003;</strong>';
					} elseif (strpos($state, 'b' . $id . '=wip') !== false) {
						echo '<strong class="mr-2 text-warning"><i class="fas fa-wrench"></i></strong>';
					} else {
						echo '<strong class="mr-2 text-danger">&#10007;</strong>';
					}
					if (count($data['sub']) != 0) echo '<a href="#sub_' . $id . '" data-toggle="collapse" class="text-secondary">';
					echo $data['name'];
					if (count($data['sub']) != 0) echo '</a>';
					echo '<br>';

					if (strpos($state, 'b' . $id . '=wip') !== false) {
						echo '<div id="sub_' . $id . '" class="collapse show">';
					} else {
						echo '<div id="sub_' . $id . '" class="collapse">';
					}
					foreach ($data['sub'] as $sid => $name) {
						echo '<small>';
						if (strpos($state, 's' . $id . '_' . $sid . '=true') !== false) {
							echo '<strong class="mr-2 text-success">&emsp;&#10003;</strong>';
						} elseif (strpos($state, 's' . $id . '_' . $sid . '=wip') !== false) {
							echo '<strong class="mr-2 text-warning">&emsp;<i class="fas fa-wrench"></i></strong>';
						} else {
							echo '<strong class="mr-2 text-danger">&emsp;&#10007;</strong>';
						}
						echo $name;
						echo '</small>';
						echo '<br>';
					}
					echo '</div>';

					echo '</div>';
				}
				?>
			</div>

			<a class="btn btn-primary" href=".main-container" data-toggle="collapse"><i class="fas fa-backward mr-2"></i>Go back</a>

		</div>

		<small class="text-muted" style="position: absolute; bottom: 8px; right: 8px;">
			Auto-Setup Script | Ubuntu 18.04 LTS | by Tassilo
		</small>

	</body>

</html>
