require_relative 'spec_helper'

describe file('/etc/ssh/sshd_config') do
  it { should contain 'ChallengeResponseAuthentication no' }
  it { should contain 'UsePAM yes' }
  it { should contain 'PasswordAuthentication no' }
  it { should contain 'PermitRootLogin no' }
  it { should contain 'AuthorizedKeysFile %h/.ssh/authorized_keys' }
  it { should contain 'X11Forwarding yes' }
  it { should contain 'Protocol 2' }
  it { should contain 'SyslogFacility AUTHPRIV' }
  it { should contain 'GssapiAuthentication yes' }
  it { should contain 'GssapiCleanUpCredentials yes' }
  it { should contain 'AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES' }
  it { should contain 'AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT' }
  it { should contain 'AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE' }
  it { should contain 'AcceptEnv XMODIFIERS' }
  it { should contain 'PubkeyAuthentication yes' }
  it { should contain 'RSAAuthentication yes' }
  if os[:family] == 'redhat'
    it { should contain "Subsystem sftp /usr/libexec/openssh/sftp-server" }
    if os[:release].to_f >= 7
      it { should contain "UsePrivilegeSeparation sandbox" }
      it { should contain "HostKey /etc/ssh/ssh_host_rsa_key" }
      it { should contain "HostKey /etc/ssh/ssh_host_ecdsa_key" }
      it { should contain "HostKey /etc/ssh/ssh_host_ed25519_key" }
    end
  end
end

#include_recipe 'ntp'
describe file('/etc/ntp.conf') do
  it { should contain 'tinker panic 0' }
  it { should contain 'statsdir /var/log/ntpstats/' }
  it { should contain 'driftfile /var/lib/ntp/ntp.drift' }
  it { should contain 'disable monitor' }
  it { should contain 'server 0.amazon.pool.ntp.org. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict 0.amazon.pool.ntp.org. nomodify notrap noquery' }
  it { should contain 'server 1.amazon.pool.ntp.org. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict 1.amazon.pool.ntp.org. nomodify notrap noquery' }
  it { should contain 'server 2.amazon.pool.ntp.org. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict 2.amazon.pool.ntp.org. nomodify notrap noquery' }
  it { should contain 'server 3.amazon.pool.ntp.org. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict 3.amazon.pool.ntp.org. nomodify notrap noquery' }
  it { should contain 'server doc1.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict doc1.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'server moc1.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict moc1.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'server moc2.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict moc2.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'server poc1.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict poc1.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'server poc2.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict poc2.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'server voc1.stratum2.gannett.com. iburst minpoll 6 maxpoll 10' }
  it { should contain 'restrict voc1.stratum2.gannett.com. nomodify notrap noquery' }
  it { should contain 'restrict default kod notrap nomodify nopeer noquery' }
  it { should contain 'restrict 127.0.0.1 nomodify' }
  it { should contain 'restrict -6 default kod notrap nomodify nopeer noquery' }
  it { should contain 'restrict -6 ::1 nomodify' }
end

#describe command('sysctl -a | grep conntrack') do
#  its(:stdout) { should contain '250000' }
#end
