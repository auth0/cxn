include_recipe 'sysctl::default'

# Netflix defaults
# http://wiki.mikejung.biz/Sysctl_tweaks#Netflix_2014_EC2_sysctl_tweaks

sysctl_param 'vm.swappiness' do
  value 20
end

sysctl_param 'vm.dirty_background_ratio' do
  value 10
end

sysctl_param 'vm.dirty_ratio' do
  value 40
end

sysctl_param 'net.core.somaxconn' do
  value 1000
end

sysctl_param 'net.core.netdev_max_backlog' do
  value 5000
end

sysctl_param 'net.core.rmem_max' do
  value 16_777_216
end

sysctl_param 'net.core.wmem_max' do
  value 16_777_216
end

sysctl_param 'net.ipv4.tcp_wmem' do
  value '4096 12582912 16777216'
end

sysctl_param 'net.ipv4.tcp_rmem' do
  value '4096 12582912 16777216'
end

sysctl_param 'net.ipv4.tcp_max_syn_backlog' do
  value 8096
end

sysctl_param 'net.ipv4.tcp_slow_start_after_idle' do
  value 0
end

sysctl_param 'net.ipv4.tcp_tw_reuse' do
  value 1
end

sysctl_param 'fs.file-max' do
  value 20_480
end
