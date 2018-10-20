package 'stunnel'

service 'stunnel' do
  service_name 'stunnel4'
  supports restart: true
  action %i[enable start]
end

remote_directory '/etc/stunnel' do
  source 'stunnel'
end

template "#{node['stunnel']['conf_dir']}/stunnel4" do
  source 'stunnel/stunnel4.erb'
  notifies :restart, 'service[stunnel]'
end
