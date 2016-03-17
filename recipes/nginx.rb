apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/development/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end

if node['cxn']['logging'] then
    node.set['nginx']['access_log'] = [
      '/var/log/nginx/access.log acc_log',
      "syslog:server=#{node['rsyslog']['host']}:#{node['rsyslog']['port']} acc_log"
    ]
else
    node.set['nginx']['access_log'] = [
      '/var/log/nginx/access.log acc_log'
    ]
end

include_recipe 'nginx'

package 'nginx-extras' do
  notifies :reload, 'service[nginx]'
end

template "#{node['nginx']['dir']}/sites-enabled/00-purger" do
  source 'nginx/purgers.conf.erb'
  notifies :reload, 'service[nginx]'
  variables(
    varnish_address:     'localhost',
    varnish_port:        node['varnish']['listen_port'],
    purgers:             node['cxn']['purgers'].values + node['cxn']['nodes'].values
  )
end

logrotate_app 'nginx' do
  cookbook  'logrotate'
  frequency 'hourly'
  path      '/var/log/nginx/*.log'
  options   ['missingok', 'compress', 'notifempty', 'sharedscripts']
  create    '0640 www-data adm'
  rotate    30
  su        'root'
  size      '50M'
  postrotate '[ -s /run/nginx.pid ] && kill -USR1 `cat /run/nginx.pid`'
  prerotate <<-EOF
  if [ -d /etc/logrotate.d/httpd-prerotate ]; then \\
      run-parts /etc/logrotate.d/httpd-prerotate; \\
    fi \\
EOF
end

link '/etc/cron.hourly/logrotate' do
  to '/etc/cron.daily/logrotate'
  link_type :symbolic
end

template "/etc/default/nginx" do
  source 'nginx/default_nginx.erb'
  notifies :reload, 'service[nginx]'
end

node['cxn']['domains'].each do |config|
  template "#{node['nginx']['dir']}/sites-enabled/#{config.domain}" do

    if config.ssl then
      source 'nginx/domain.conf.erb'
    else
      source 'nginx/domain.http.conf.erb'
    end

    notifies :reload, 'service[nginx]'

    variables(
      domain:              config.domain,
      ssl:                 config.ssl,
      ssl_certificate:     "/etc/ssl/localcerts/#{config.domain}.crt",
      ssl_certificate_key: "/etc/ssl/localcerts/#{config.domain}.key",
      purgers:             node['cxn']['purgers'].values + node['cxn']['nodes'].values,
      nodes:               node['cxn']['nodes'].values
    )
  end

  if config.ssl then
    directory "/etc/ssl/localcerts"

    cookbook_file "/etc/ssl/localcerts/#{config.domain}.crt" do
      source "localcerts/#{config.domain}.crt"
      mode '0600'
      owner node['nginx']['user']
      notifies :reload, 'service[nginx]'
    end

    cookbook_file "/etc/ssl/localcerts/#{config.domain}.key" do
      source "localcerts/#{config.domain}.key"
      mode '0600'
      owner node['nginx']['user']
      notifies :reload, 'service[nginx]'
    end
  end

end
