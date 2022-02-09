require "spec_helper"
require "serverspec"

package = "nginx"
service = "nginx"
config_dir = "/etc/nginx"
user    = "www-data"
group   = "www-data"
ports   = [80, 443]
log_dir = "/var/log/nginx"
default_user = "root"
default_group = "root"
log_owner = ""
log_group = ""
log_mode = 644

case os[:family]
when "ubuntu", "devuan"
  log_owner = user
  log_group = "adm"
  log_mode = 640
when "redhat", "fedora"
  user = "nginx"
  group = "nginx"
  log_owner = default_user
  log_group = default_group
when "openbsd"
  user = "www"
  group = "www"
  config_dir = "/etc/nginx"
  default_group = "wheel"
  log_dir = "/var/www/logs"
  log_owner = default_user
  log_group = group
when "freebsd"
  user = "www"
  group = "www"
  config_dir = "/usr/local/etc/nginx"
  default_group = "wheel"
  log_owner = default_user
  log_group = group
end
config = "#{config_dir}/nginx.conf"

describe package(package) do
  it { should be_installed }
end

case os[:family]
when "ubuntu", "devuan"
  describe file("/etc/default/nginx") do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/^DAEMON_OPTS=""$/) }
  end
when "openbsd"
  describe file("/etc/rc.conf.local") do
    it { should exist }
    it { should be_file }
    its(:content) { should_not match(/^nginx_flags=/) }
  end
when "freebsd"
  describe file("/etc/rc.conf.d/nginx") do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/^nginx_flags=""$/) }
  end
end

describe file("#{config_dir}/conf.d/foo.conf") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/^# FOO$/) }
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(%r{^\s+include\s+#{config_dir}/mime\.types;$}) }
  if os[:family] == "ubuntu" || os[:family] == "redhat" || os[:family] == "fedora" || os[:family] == "devuan"
    its(:content) { should match(/^user #{user};$/) }
    its(:content) { should match(/^pid #{Regexp.escape("/run/nginx.pid")};$/) }
  end
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

["access.log", "error.log"].each do |f|
  describe file("#{log_dir}/#{f}") do
    it { should exist }
    it { should be_mode log_mode }
    it { should be_owned_by log_owner }
    it { should be_grouped_into log_group }
  end
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command("echo | openssl s_client -connect 127.0.0.1:443 -showcerts") do
  case os[:family]
  when "freebsd", "ubuntu", "devuan", "fedora"
    # newer openssl
    # issuer=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = foo.example.org
    its(:stdout) { should match(/#{Regexp.escape("issuer=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = foo.example.org")}/) }
  else
    its(:stdout) { should match(/#{Regexp.escape("issuer=/C=AU/ST=Some-State/O=Internet Widgits Pty Ltd/CN=foo.example.org")}/) }
  end
  its(:stderr) { should match(/verify error:num=\d+:(?:self signed certificate|unable to get local issuer certificate)/) }
  its(:exit_status) { should eq 0 }
end
