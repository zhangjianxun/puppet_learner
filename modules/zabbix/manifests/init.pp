class zabbix {
  yumrepo { 'zabbix':
    baseurl     => "http://repo.zabbix.com/zabbix/2.0/rhel/6/x86_64/",
    descr       => "zabbix official repository",
    enabled     => 1,
    gpgcheck    => 0,
  }
  package { 'zabbix-agent':
    ensure 	=> installed,
    allow_virtual => false,
    require     => Yumrepo ["zabbix"],
  }
  file { '/etc/zabbix/zabbix_agentd.conf':
    content     => template("zabbix/zabbix_agentd_conf.erb"),
    ensure      => file,
  }
  service { 'zabbix-agent':
    ensure      => "running",
    hasstatus   =>  true,
    enable      =>  true,
    subscribe   => [File["/etc/zabbix/zabbix_agentd.conf"]],
  }
  Package["zabbix-agent"] -> File["/etc/zabbix/zabbix_agentd.conf"] -> Service["zabbix-agent"]

}

