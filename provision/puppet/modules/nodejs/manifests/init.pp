class nodejs {
	exec { "node-setup":
		command => "curl -sL https://deb.nodesource.com/setup | sudo bash -"
	}

	# Install node and npm
	package { "nodejs":
		ensure  => present,
		require => [ Exec["node-setup"], Exec["apt-get update"] ]
	}

	# Because of a package name collision, 'node' is called 'nodejs' in Ubuntu.
	file { "/usr/bin/node":
		ensure => "link",
		target => "/usr/bin/nodejs",
		require => Package["nodejs"]
	}

	# Install global node packages.
	npm_global_install { [ "forever" ]:
		require => [ Package["nodejs"] ],
	}

	# Install local node packages.
	npm_install { [ "/vagrant/app" ]:
		require => [ Package["nodejs"] ],
	}
}