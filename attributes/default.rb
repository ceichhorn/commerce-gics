default['datadog']['agent_enable'] = false
default['datadog']['agent_start'] = false

default['ruby-deployment']['application']['name'] = 'contractor-management'
default['ruby-deployment']['application']['repository'] = 'ecommerce-binaries'
default['ruby-deployment']['application']['version'] = '13'
default['ruby-deployment']['application']['migrate'] = true
default['ruby-deployment']['application']['migration_command'] =
  'bundle install --deployment && bundle exec rake db:migrate && RAILS_ENV=production bin/rake assets:precompile'

default['ruby-deployment']['application']['env_vars'] =
  [{ 'name' => 'APPLICATION_EMAIL', 'value' => 'wspencer@gannett.com' }]

default['ruby-deployment']['build_dependencies'] = ['ibm-iaccess', 'unixODBC-devel', 'mariadb-devel', 'sqlite-devel', 'gmp-devel', 'zlib-devel', 'ruby-devel', 'libcurl-devel', 'gcc-c++']

default['yum-gd']['repos'] = ['yum-ibm', 'gdcustom', 'datadog', 'scalr']

default['ruby-deployment']['gem_dependencies'] = [
{ name: 'rake', version: '10.4.2' },
{ name: 'json_pure', version: '1.8.2' },
{ name: 'rails', version: '2.3.17' },
{ name: 'net-ssh', version: '2.9.2' },
{ name: 'activemodel', version: '3.2.13' },
{ name: 'acts_as_reportable', version: '1.1.1' },
{ name: 'arel', version: '3.0.2' },
{ name: 'aws', version: '2.5.6' },
{ name: 'builder', version: '3.2.2' },
{ name: 'bundler', version: '1.3.5' },
{ name: 'color', version: '1.7.1' },
{ name: 'columnize', version: '0.3.6' },
{ name: 'composite_primary_keys', version: '2.2.2' },
{ name: 'daemon_controller', version: '1.0.0' },
{ name: 'diff-lcs', version: '1.2.4' },
{ name: 'erubis', version: '2.7.0' },
{ name: 'fastercsv', version: '1.5.5' },
{ name: 'fastthread', version: '1.0.7' },
{ name: 'hoe', version: '2.1.0' },
{ name: 'http_connection', version: '1.4.4' },
{ name: 'i18n', version: '0.6.1' },
{ name: 'httpclient', version: '2.1.5.2' },
{ name: 'journey', version: '1.0.4' },
{ name: 'json', version: '1.8.3' },
{ name: 'linecache', version: '0.46' },
{ name: 'mail', version: '2.5.4' },
{ name: 'mime-types', version: '1.25.1' },
{ name: 'multi_json', version: '1.11.2' },
{ name: 'net-sftp', version: '2.0.5' },
{ name: 'passenger', version: '3.0.12' },
{ name: 'pdf-writer', version: '1.1.8' },
{ name: 'polyglot', version: '0.3.5' },
{ name: 'rack', version: '1.4.7' },
{ name: 'rack-cache', version: '1.2' },
{ name: 'rack-ssl', version: '1.3.3' },
{ name: 'rack-test', version: '0.6.2' },
{ name: 'railties', version: '3.2.13' },
{ name: 'rcov', version: '0.8.1.2.0' },
{ name: 'rdoc', version: '3.12.2' },
{ name: 'rest-client', version: '1.6.7' },
{ name: 'rspec', version: '1.2.7' },
{ name: 'rspec-core', version: '2.13.1' },
{ name: 'rspec-expectations', version: '2.13.0' },
{ name: 'rspec-mocks', version: '2.13.1' },
{ name: 'rspec-rails', version: '1.2.7.1' },
{ name: 'ruby-debug', version: '0.10.4' },
{ name: 'ruby-debug-base', version: '0.10.4' },
{ name: 'ruby-net-ldap', version: '0.0.4' },
{ name: 'ruby-odbc', version: '0.99991' },
{ name: 'rubyforge', version: '2.0.4' },
{ name: 'rubygems-update', version: '2.0.3' },
{ name: 'ruport', version: '1.6.3' },
{ name: 'soap4r', version: '1.5.8' },
{ name: 'sprockets', version: '2.2.3' },
{ name: 'thor', version: '0.19.1' },
{ name: 'thread_safe', version: '0.3.5' },
{ name: 'tilt', version: '1.4.1' },
{ name: 'transaction-simple', version: '1.4.0.2' },
{ name: 'treetop', version: '1.4.15' },
{ name: 'tzinfo', version: '1.2.2' },
{ name: 'uuidtools', version: '2.1.5' },
{ name: 'xml-simple', version: '1.1.5' }
]
default['ruby-deployment']['ruby']['version'] = 'ruby-1.8.7.374-4.el6_6'
default['ruby-deployment']['passenger']['version'] = '3.0.12'
default['ruby-deployment']['passenger']['root'] = "/usr/lib64/ruby/gems/2.2.0/gems/passenger-#{node['ruby-deployment']['passenger']['version']}"
default['ruby-deployment']['passenger']['install'] = false
default['ruby-deployment']['newrelic_enabled'] = false

default['ruby-deployment']['config-from-s3'] = true
default['ruby-deployment']['s3-config-bucket'] = "gdp-commerce-configs/#{node['ruby-deployment']['application']['name']}"
default['ruby-deployment']['s3']['test_config'] = false

default['ruby-deployment']['nginx']['port'] = 80

default['ruby-deployment']['application']['configuration_files'] = ["#{node['ruby-deployment']['application']['app_env']}-secrets.yml", "#{node['ruby-deployment']['application']['app_env']}-database.yml"] # rubocop:disable Style/LineLength
default['ruby-deployment']['config-dir'] = 'config'

normal['splunk']['cookbook'] = 'chef-splunk'
default['splunk']['user'] = {
  'username' => 'splunk',
  'comment'  => 'Splunk Server',
  'home'     => '/opt/splunkforwarder',
  'shell'    => '/bin/bash',
  'uid'      => 396
}
normal['splunk']['apps'] += [
  { name: 'nginxlogs_inputs', templates: ['inputs.conf'], template_cookbook: 'splunk_support' },
  { name: 'railslogs_inputs', templates: ['inputs.conf'], template_cookbook: 'splunk_support' }
]
