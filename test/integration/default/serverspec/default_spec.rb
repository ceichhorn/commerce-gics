require 'spec_helper'

describe file("#{$node['ruby-deployment']['home']}/#{$node['ruby-deployment']['application']['name']}") do
  it 'this home directory exists' do
    expect(subject).to exist
  end
end

describe file("#{$node['ruby-deployment']['home']}/#{$node['ruby-deployment']['application']['name']}/tmp/pids") do
  it 'this pids directory exists' do
    expect(subject).to exist
  end
end

describe file("#{$node['ruby-deployment']['home']}/#{$node['ruby-deployment']['application']['name']}/public/system/") do
  it 'this system directory exists' do
    expect(subject).to exist
  end
end

describe "commerce-contractor-management::default" do
  # tests that should not change based on attributes
  describe file('/etc/nginx') do
    it { should exist }
    it { should be_directory }
  end

  describe file('/etc/nginx/nginx.conf') do
    it { should exist }
    it { should be_file }
  end

  describe process('nginx') do
    it { should be_running }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/nginx/conf.d/') do
    it { should exist }
    it { should be_directory }
  end

    describe file('/etc/nginx/conf.d/passenger.conf') do
    it { should exist }
    it { should be_file }
  end

  describe file('/usr/bin/passenger') do
    it { should exist }
    it { should be_file }
    it { should be_executable }
  end

  describe command('passenger-config validate-install --auto') do
    its(:exit_status) { should eq 0 }
  end

  # tests that may change based on attributes
  describe user("#{$node['ruby-deployment']['user']}") do
    it { should exist }
    it { should have_home_directory "#{$node['ruby-deployment']['homedir']}"}
    it { should have_login_shell '/bin/bash' }
  end

  describe file("#{$node['ruby-deployment']['homedir']}") do
    it { should exist }
    it { should be_directory }
  end

  describe package('nginx') do
    it {should be_installed.with_version("#{$node['nginx']['version']}") }
  end

  # firewall and port checks
  describe port("#{$node['ruby-deployment']['nginx']['port']}") do
    it { should be_listening.with('tcp') }
  end

  describe service('firewalld') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('firewall-cmd --permanent --direct --get-all-rules') do
    its(:stdout) { should contain "ipv4 filter INPUT 50 -p tcp -m tcp -m multiport --dports #{$node['ruby-deployment']['nginx']['port']} -m comment --comment http -j ACCEPT" }
  end
end

describe port(443) do
  it { should be_listening.with('tcp') }
end

describe command('curl https://localhost -k') do
  its(:stdout) { should match /Independent Contractor Inquiry/ }
  its(:exit_status) {should eq 0 }
  it 'no bad gateway from nginx' do
    expect(subject.stdout).not_to match(/502 Bad Gateway/)
  end
end
