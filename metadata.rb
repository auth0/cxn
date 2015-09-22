name 'cxn'
maintainer 'Jose F. Romaniello'
maintainer_email 'jose@auth0.com'
license 'Apache 2.0'
description 'Installs/Configures kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

%w(nginx varnish apt newrelic hostsfile sysctl).each do |cb|
  depends cb
end

supports 'ubuntu'

