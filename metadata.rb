name 'cxn'
maintainer 'Jose F. Romaniello'
maintainer_email 'jose@auth0.com'
license 'Apache 2.0'
description 'Installs/Configures kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

depends 'apt'
depends 'ohai'
depends 'newrelic'
depends 'rsyslog'
depends 'build-essential'
depends 'nginx'
depends 'varnish', '~> 3.0.0'
depends 'hostsfile', '~> 2.4.5'
depends 'sysctl', '~> 0.6.2'
depends 'logrotate', '~> 1.9.2'


supports 'ubuntu'

