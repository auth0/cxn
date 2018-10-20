include_recipe 'varnish::configure'

logrotate_app 'varnish' do
  cookbook  'logrotate'
  frequency 'hourly'
  path      '/var/log/varnish/varnishlog.log'
  options   %w[missingok compress notifempty delaycompress]
  rotate    10
  su        'root'
  size      '200M'
  postrotate '	/bin/kill -HUP `cat /var/run/varnishlog.pid 2>/dev/null` 2> /dev/null || true'
end
