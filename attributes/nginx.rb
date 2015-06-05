override['nginx']['version'] = '1.7.7'

override['nginx']['default_site_enabled'] = false
override['nginx']['upstream_repository'] = 'http://ppa.launchpad.net/nginx/stable/ubuntu'
override['nginx']['worker_processes'] = 4
override['nginx']['gzip'] = 'off'
override['nginx']['server_tokens'] = 'off'

override['nginx']['install_method'] = 'package'
override['nginx']['repo_source'] = 'ppa'

override['nginx']['log_formats'] = {
  "acc_log" => %{'$remote_addr - $remote_user [$time_local] '
                   '"$request" $status $bytes_sent '
                   '"$http_referer" "$http_user_agent" "$gzip_ratio" '
                   '"$sent_http_x_cache" $request_time'}
}

override['nginx']['client_body_buffer_size'] = "10k"
override['nginx']['client_max_body_size'] = "10k"

# Reload nginx::source attributes with our updated version
node.from_file(run_context.resolve_attribute('nginx', 'source'))