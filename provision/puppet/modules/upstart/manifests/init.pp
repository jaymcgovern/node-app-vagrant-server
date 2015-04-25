class upstart {
	file { "/etc/init/node-app.conf":
		ensure  => file,
		source  => "/vagrant/provision/upstart/node-app.conf",
		require => Class["Nodejs"],
	}

	service { "node-app":
		ensure => running,
		provider => "upstart",
		require => [ File["/etc/init/node-app.conf"] , Class["Bower"], Class["Nginx"] ],
	}
}