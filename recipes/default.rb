include_recipe 'cxn::nginx'
include_recipe 'cxn::varnish'
include_recipe 'cxn::newrelic'
include_recipe 'cxn::hostname'
include_recipe 'cxn::sysctl'
include_recipe 'cxn::ntp'

if node['cxn']['logging']
  include_recipe 'cxn::stunnel'
  include_recipe 'cxn::rsyslog'
end
