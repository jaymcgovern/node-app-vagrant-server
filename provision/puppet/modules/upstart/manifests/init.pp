class upstart {
	file { "/etc/init/node-app.conf":
		ensure  => present,
		content => template( "upstart/node-app.conf.erb" ),
		require => Class["Nodejs"],
	}

	service { "node-app":
		ensure => running,
		provider => "upstart",
		require => [ File["/etc/init/node-app.conf"] , Class["Bower"], Class["Nginx"] ],
	}
}