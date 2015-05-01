class nginx {
	package { "nginx":
		ensure  => present,
		require => Exec["apt-get update"],
	}

	service { "nginx":
        ensure     => running,
        enable     => true,
        hasrestart => true,
        require    => Package["nginx"],
	}

	file { "nginx_config":
		ensure  => present,
		path    => "/etc/nginx/sites-available/site",
		content => template( "nginx/site.erb" ),
		require => Package["nginx"],
	}

	file { "nginx_remove_default_config":
		path    => "/etc/nginx/sites-available/default",
		ensure  => absent,
		require => File["nginx_config"],
	}

	exec { "nginx_enable_site":
		command => "ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled",
		require => [ File["nginx_config"], File["nginx_remove_default_config"] ],
		notify  => Service["nginx"],
	}

	#file { "nginx_enable_site":
	#	ensure => link,
	#	path   => "/etc/nginx/sites-available/site",
	#	target => "/etc/nginx/sites-enabled/site",
	#	require => [ File["nginx_config"], File["nginx_remove_default_config"] ],
	#}
}