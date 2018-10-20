file '/etc/hostname' do
  content node.name
end

execute "hostname #{node.name}" do
  not_if "hostname -eq \"#{node.name}\""
end

hostsfile_entry '127.0.1.1' do
  hostname  "#{node.name}.cdn.auth0"
  aliases   [node.name]
end

node['cxn']['nodes'].sort.each do |host, ip|
  next if host == node.name

  hostsfile_entry ip do
    hostname host
  end
end
