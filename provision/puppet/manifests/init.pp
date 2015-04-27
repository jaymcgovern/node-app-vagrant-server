# Tell Puppet where to find system commands.
Exec {
  path => [ "/usr/sbin", "/usr/bin", "/sbin", "/bin", "/usr/local/bin" ]
}

exec { "apt-get update": }

########################
# Utilities
########################

define npm_global_install(){
	exec { "npm_global_install_${name}":
		command => "npm install ${name} -g",
		require =>  Package["nodejs"],
		timeout => 0 # disable timeout
	}
}

define npm_install(){
	exec { "npm_install_${name}":
		command => "npm install",
		cwd     => $name,
		require =>  [Package["nodejs"]],
		timeout => 0, # disable timeout,
		onlyif  => "test -e /vagrant/app/package.json",
	}
}

include nodejs
include bower
include nginx
include upstart