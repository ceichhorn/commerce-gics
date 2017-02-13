require_relative 'spec_helper'

if ENV['OS'] == 'Windows_NT'
  splunk_base_dir = 'C:/Program Files/SplunkUniversalForwarder'
  splunk_command = 'C:\\"Program Files"\\SplunkUniversalForwarder\\bin\\splunk.exe'
  describe file("#{splunk_base_dir}/bin/splunk.exe") do
    it { should exist }
  end
else
  splunk_base_dir = '/opt/splunkforwarder'
  splunk_command = "#{splunk_base_dir}/bin/splunk"
  describe file("#{splunk_command}") do
    it { should exist }
    it { should be_executable }
  end
end
describe file("#{splunk_base_dir}/bin/") do
  it { should exist }
  it { should be_directory }
end

describe service("#{$node['splunk']['service']}") do
  it { should be_enabled }
end

describe 'outputs config should be configured per node attributes' do
  describe file("#{splunk_base_dir}/etc/system/local/outputs.conf") do
    it { should be_file }
    # TODO: why is this test here?
    # its(:content) { should match(/defaultGroup=#{$node['splunk']['indexers_group1']['name']}, #{$node['splunk']['indexers_group2']['name']}/) }
    # from the default attributes
    its(:content) { should match(/forwardedindex.0.whitelist = .*/) }
    its(:content) { should match(/forwardedindex.1.blacklist = _.*/) }
    its(:content) { should match(/forwardedindex.2.whitelist = _audit/) }
    its(:content) { should match(/forwardedindex.filter.disable = false/) }
    # tcpout
    its(:content) { should match(/[tcpout:#{$node['splunk']['indexers_group1']['name']}]/) }
    its(:content) { should match(/[tcpout:#{$node['splunk']['indexers_group2']['name']}]/) }
    its(:content) { should match(/server=inputs1.gannett.splunkcloud.com:9997, inputs2.gannett.splunkcloud.com:9997, inputs3.gannett.splunkcloud.com:9997, inputs4.gannett.splunkcloud.com:9997, inputs5.gannett.splunkcloud.com:9997/) }
  end
end

describe command("#{splunk_command} display app -auth admin:changeme") do
  its(:stdout) { should contain('gannett_splunkcloud')}
  its(:stdout) { should contain('generallogs_inputs')}
  its(:stdout) { should contain('scalarizrlogs_inputs')}
end

# splunk apps from default attributes
describe file("#{splunk_base_dir}/etc/apps/gannett_splunkcloud/default/app.conf") do
  its(:content) { should contain("0.0.1")}
end

describe file("#{splunk_base_dir}/etc/apps/generallogs_inputs/local/inputs.conf") do
  it { should be_file }
  its(:content) { should contain("syslog")}
end

describe file("#{splunk_base_dir}/etc/apps/scalarizrlogs_inputs/local/inputs.conf") do
  it { should be_file }
  its(:content) { should contain("index = #{$node['splunk']['env_prefix']}#{$node['splunk']['environment']}")}
end

# make sure old 'splunk' cookbook stuff is gone
describe file('/root/splunk_linux_install.sh') do
  it { should_not exist }
end

describe file('/root/splunk_config.sh') do
  it { should_not exist }
end

describe file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf') do
  it { should_not exist }
end

describe cron do
  it { should_not have_entry '*/5 * * * * /root/./splunk_config.sh' }
end

describe package('splunkforwarder') do
  it { should be_installed.with_version($node['splunk']['version']) }
end
