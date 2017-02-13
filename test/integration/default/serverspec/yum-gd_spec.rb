require_relative 'spec_helper'

describe file('/etc/yum.repos.d/scalr.repo') do
  it { should contain 'enabled=1' }
end
describe file('/etc/yum.repos.d/gdcustom.repo') do
  it { should contain 'enabled=1' }
end
describe file('/etc/yum.repos.d/datadog.repo') do
  it { should contain 'enabled=1' }
end
