if node['cxn']['newrelic'] then
  node.set['newrelic']['license'] = node['cxn']['newrelic']
  include_recipe 'newrelic'
end