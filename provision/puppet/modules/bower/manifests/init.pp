class bower {
	# Install global node packages.
	npm_global_install { [ "bower" ]:
		require => [ Package["nodejs"] ],
	}

	# Install local bower packages.
	exec { "bower_install":
		command     => "bower install --config.interactive=false",
		cwd         => "/vagrant/app",
		user        => "vagrant",
		require     => Npm_global_install["bower"],
		environment => "HOME=/home/vagrant",
		onlyif      => "test -e /vagrant/app/bower.json",
	}
}