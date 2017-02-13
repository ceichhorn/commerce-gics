require_relative 'spec_helper'

describe file('/opt/datadog-agent/agent/checks.d/conntrack.py') do
  it { should be_file }
  it { should be_owned_by 'dd-agent' }
    it { should contain('class Conntrack(AgentCheck)') }
end
