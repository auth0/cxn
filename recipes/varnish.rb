node.set['varnish']['vcl_generated'] = false
node.set['varnish']['vcl_source'] = 'varnish.vcl.erb'
node.set['varnish']['vcl_cookbook'] = 'cxn'
node.set['varnish']['instance'] = node.name

node.set['varnish']['storage'] = node['cxn']['varnish']['storage']
node.set['varnish']['storage_size'] = node['cxn']['varnish']['storage_size']

include_recipe 'varnish'

template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}"  do
  source 'varnish/varnish.vcl.erb'
  notifies :reload, 'service[varnish]'
end

varnish_default_config 'default' do
  start_on_boot true
  max_open_files 131_072
  max_locked_memory 82_000
  listen_address nil
  listen_port 6081
  path_to_vcl '/etc/varnish/default.vcl'
  admin_listen_address '127.0.0.1'
  admin_listen_port 6082
  user 'varnish'
  group 'varnish'
  ttl 120
  storage 'malloc'
  malloc_size "#{(node['memory']['total'][0..-3].to_i * 0.75).to_i}K"
  parameters(thread_pools: '2',
             thread_pool_min: '5',
             thread_pool_max: '500',
             thread_pool_timeout: '300')
  path_to_secret '/etc/varnish/secret'
end