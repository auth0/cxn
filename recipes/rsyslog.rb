service 'rsyslog' do
  provider Chef::Provider::Service::Upstart
  supports restart: true
  action %i[enable start]
end

template "#{node['rsyslog']['conf_dir']}/10-udp_listener.conf" do
  source 'rsyslog/10-udp_listener.conf.erb'
  notifies :restart, 'service[rsyslog]'
end

template "#{node['rsyslog']['conf_dir']}/55-nginx.conf" do
  source 'rsyslog/55-nginx.conf.erb'
  notifies :restart, 'service[rsyslog]'
end
