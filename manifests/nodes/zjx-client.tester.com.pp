node 'zjx-client.tester.com' {
  $vhostname='zjx-client.tester.com'
  $vhostport='80'
  $vhostroot='/var/www/html'
  $zabbix_server="zjx-server.tester.com"
  include zabbix
#  include nginx
 
}
