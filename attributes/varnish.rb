override['varnish']['parameters'] = {
  "ban_lurker_sleep" => "0.01",
  "ban_lurker_age" => "0.01"
}

override['varnish']['configure']['repo']['major_version'] = 4.1
override['varnish']['configure']['config']['listen_address'] = '0.0.0.0'
override['varnish']['configure']['config']['listen_port'] = 80
override['varnish']['configure']['config']['malloc_percent'] = 33


override['varnish']['configure']['config']['max_open_files']       = 131_072
override['varnish']['configure']['config']['max_locked_memory']    = 82_000
override['varnish']['configure']['config']['listen_address']       = nil
override['varnish']['configure']['config']['listen_port']          = 6081
override['varnish']['configure']['config']['admin_listen_address'] = '127.0.0.1'
override['varnish']['configure']['config']['admin_listen_port']    = 6082
override['varnish']['configure']['config']['user']                 = 'varnish'
override['varnish']['configure']['config']['group']                = 'varnish'
override['varnish']['configure']['config']['ttl']                  = 120
override['varnish']['configure']['config']['storage']              = 'malloc'
override['varnish']['configure']['config']['malloc_size']          = "#{(node['memory']['total'][0..-3].to_i * 0.75).to_i}K"
override['varnish']['configure']['config']['path_to_secret']       = '/etc/varnish/secret'
override['varnish']['configure']['config']['parameters'] = {
    thread_pools: '2',
    thread_pool_min: '5',
    thread_pool_max: '500',
    thread_pool_timeout: '300'
}

override['varnish']['configure']['config']['storage'] = node['cxn']['varnish']['storage']
override['varnish']['configure']['config']['file_storage_size'] = node['cxn']['varnish']['storage_size']

override['varnish']['configure']['vcl_template']['source'] = 'varnish/varnish.vcl.erb'
override['varnish']['configure']['vcl_template']['cookbook'] = 'cxn'

override['varnish']['configure']['log']['log_format'] = 'varnishncsa'
override['varnish']['configure']['ncsa']['logrotate'] = false
override['varnish']['configure']['log']['logrotate'] = false
