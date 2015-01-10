class nginx{
	yumrepo { 'nginx_repo':
		baseurl       => 'http://nginx.org/packages/centos/6/x86_64/',
		gpgcheck      => '0',
		enabled       => '1',
	}
	package { 'nginx':
		allow_virtual => false, 
		ensure        => present,
		require       => Yumrepo["nginx_repo"],
	}
	file { 'nginx.conf':	
  		ensure 	      => present,	
		path	      => "/etc/nginx/nginx.conf",
      		source        => "puppet:///modules/nginx/nginx.conf",
		require       => Package ['nginx'],
	}
	file { '/etc/nginx/nginx':
		ensure 	      => directory,
		}
	file {'vhosts.conf':
		path	      => '/etc/nginx/conf.d/vhost.conf',
		content	      => template("nginx/vhosts.conf.erb"),
		require       => Package ['nginx'],
		notify	      => Exec ['reload'],
		tag 	      => 'vhost.conf',
	}
	service {'nginx':
		ensure        => running,
		enable        => true,
		require       => Package['nginx'],
	}
	exec{ 'reload':
		 refreshonly  => true,
                 command         => '/sbin/service nginx reload',
        	 onlyif       => '/etc/init.d/nginx -t -c /etc/nginx/nginx.conf',
        	 tries        => 3,
        	 try_sleep    => 5,
        }
}

