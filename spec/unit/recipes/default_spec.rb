#
# Cookbook Name:: commerce-contractor-management
# Spec:: default
#
# Copyright (c) 2016 Gannett Co., Inc, All Rights Reserved.

require 'spec_helper'

describe 'commerce-contractor-management::default' do

  context 'On Centos 7.1 with defaults set' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1.1503') do |node|
        Chef::Config[:client_key] = "/etc/chef/client.pem"
        node.set['ruby-deployment']['application']['name'] = 'contractor-management'
        node.set['ruby-deployment']['application']['version'] = '1'
        stub_command('which nginx').and_return('test')
        node.set['opsmatic']['integration_token'] = 'SomeToken'
        stub_command("which sudo").and_return('/usr/bin/sudo')
        node.set['authorization']['sudo']['groups'] = ["admin", "wheel", "test"]
        node.set['ssh_keys'] = ''
        node.default['ssh_keys'] = { test: ["test"] }
        node.set['ruby-deployment']['passenger']['install'] = true
        node.set['ruby-deployment']['build_dependencies'] = [ 'test-package' ]
        node.set['ruby-deployment']['s3']['test_config'] = true
        stub_command("which gpg2 || which gpg").and_return('/usr/bin/gpg2')
        stub_command("ps -e f |grep [P]assenger").and_return(false)
        stub_command("rpm -q datadog-agent-base")
      end.converge(described_recipe)
    end

    included_recipes = [
      'gdp-base-linux::default',
      'nginx::default',
      'nginx::http_stub_status_module'
    ]

    it 'includes the ruby recipe' do
      expect(chef_run).to include_recipe('ruby-deployment::nginx_deploy')
    end

    it 'includes the nginx recipe' do
      expect(chef_run).to include_recipe('nginx::http_stub_status_module')
    end

    it 'includes the datadog recipes' do
      expect(chef_run).to include_recipe('datadog::process')
      expect(chef_run).to include_recipe('datadog::nginx')
    end

    it 'creates rails application directories' do
      expect(chef_run).to create_directory('/opt/rubyapp/contractor-management/').with(user: 'rubyapp')
      expect(chef_run).to create_directory('/opt/rubyapp/contractor-management/tmp/pids/').with(user: 'rubyapp')
      expect(chef_run).to create_directory('/opt/rubyapp/contractor-management/public/system/').with(user: 'rubyapp')
    end

    it 'creates rails application log link' do
      expect(chef_run).to create_link('/opt/rubyapp/contractor-management/log').with(to: '/var/log/rubyapp')
    end

    it 'creates the sites-available template' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/contractor-management')
    end

    it 'creates the gemrc template' do
      expect(chef_run).to create_template('/etc/gemrc')
    end

    it 'creates sites-enabled link' do
      expect(chef_run).to create_link('/etc/nginx/sites-enabled/contractor-management')
    end

    it 'converges successfully' do
      expect{chef_run}.to_not raise_error
    end

    it 'restarts nginx after passenger is installed' do
      expect(chef_run.template('/etc/nginx/conf.d/passenger.conf')).to notify('service[nginx]').to(:restart)
    end

    it 'creates a firewall rule' do
      expect(chef_run).to create_firewall_rule('http')
    end

    it 'creates rubyapp user' do
      expect(chef_run).to create_user('rubyapp')
    end

    ['epel-release', 'pygpgme', 'curl'].each do |name|
      it 'installs ' + name do
        expect(chef_run).to install_package(name)
      end
    end
  end
end
