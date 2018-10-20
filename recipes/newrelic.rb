if node['cxn']['newrelic']
  node.set['newrelic']['license'] = node['cxn']['newrelic']
  include_recipe 'newrelic'
end
