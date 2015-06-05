default['cxn']['purgers'] = {}
default['cxn']['nodes'] = {}
default['cxn']['domains'] = []

default['cxn']['varnish']['storage'] = 'malloc'
default['cxn']['varnish']['storage_size'] = '1g'

default['cxn']['newrelic'] = false
default['cxn']['logging'] = false

default['rsyslog']['conf_dir'] = '/etc/rsyslog.d'
default['rsyslog']['host'] = 'localhost'
default['rsyslog']['port'] = '10514'

default['stunnel']['enabled'] = true
default['stunnel']['host'] = '127.0.0.1'
default['stunnel']['port'] = '11514'
default['stunnel']['conf_dir'] = '/etc/default'