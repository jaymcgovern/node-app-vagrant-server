class nodejs {
	# Install node and npm
	package { [ "nodejs", "npm" ]:
		ensure  => present,
		require => Exec["apt-get update"],
	}

	# Because of a package name collision, 'node' is called 'nodejs' in Ubuntu.
	file { "/usr/bin/node":
		ensure => "link",
		target => "/usr/bin/nodejs",
		require => Package["nodejs"]
	}

	# Install global node packages.
	npm_global_install { [ "forever" ]:
		require => [ Package["nodejs"], Package["npm"] ],
	}

	# Install local node packages.
	npm_install { [ "/vagrant/app" ]:
		require => [ Package["nodejs"], Package["npm"] ],
	}
}