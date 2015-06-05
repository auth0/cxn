include_recipe 'cxn::nginx'
include_recipe 'cxn::varnish'
include_recipe 'cxn::newrelic'
include_recipe 'cxn::hostname'

if node['cxn']['logging'] then
    include_recipe 'cxn::stunnel'
    include_recipe 'cxn::rsyslog'
end