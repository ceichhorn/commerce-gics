name 'commerce-gics'
maintainer 'Gannett Co., Inc'
maintainer_email 'commerce-solutions@gannett.com'
license ' Copyright (c) 2016 Gannett Co., Inc, All Rights Reserved.'
description 'Installs/Configures commerce-gics'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

# add any cookbook dependencies here
# depends 'other_cookbook_name'

# add any cookbook dependencies here
depends 'gdp-base-linux' 
depends 'ruby-deployment', '= 4.3.0'

supports 'centos', '>= 7.1.0'
#depends 'datadog', '= 2.6.0'
depends 'nginx', '= 2.7.8'

#source_url 'https://github.com/GannettDigital/chef-commerce-gics'
#issues_url 'https://github.com/GannettDigital/chef-commerce-gics'
