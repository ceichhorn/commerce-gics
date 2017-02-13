require_relative 'spec_helper'

describe selinux do
  it { should be_permissive }
end

describe file('/etc/selinux/config') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  it { should contain "SELINUX=permissive" }
end
