#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

haproxy_backend 'servers' do
  server [
  	'web1 3.144.181.179:80 maxconn 32',
  	'web2 13.58.2.94:80 maxconn 32'
  ]
#   notifies :reload, 'haproxy_service[haproxy]', :immediately 
#   Does not work because of current github issue
end

haproxy_service 'haproxy' do
  subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
end