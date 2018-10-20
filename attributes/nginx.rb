override['nginx']['default_site_enabled'] = false
override['nginx']['worker_processes'] = 2
override['nginx']['worker_connections'] = 20_000
override['nginx']['gzip'] = 'off'
override['nginx']['server_tokens'] = 'off'
override['nginx']['keepalive_timeout'] = '10s'

override['nginx']['install_method'] = 'package'
override['nginx']['repo_source'] = 'nginx'
override['nginx']['package_name'] = 'nginx-extras'

override['nginx']['log_formats'] = {
  'acc_log' => %('$remote_addr - $remote_user [$time_local] '
                   '"$request" $status $bytes_sent '
                   '"$http_referer" "$http_user_agent" "$gzip_ratio" '
                   '"$sent_http_x_cache" $request_time')
}

override['nginx']['client_body_buffer_size'] = '10k'
override['nginx']['client_max_body_size'] = '10k'

# Reload nginx::source attributes with our updated version
# node.from_file(run_context.resolve_attribute('nginx', 'source'))
