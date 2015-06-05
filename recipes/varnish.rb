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