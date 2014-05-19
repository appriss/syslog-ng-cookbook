default['syslog-ng'][:install_tmp_dir] = "/var/tmp/"
default['syslog-ng'][:prefix] = "/usr/local"
default['syslog-ng'][:version] = "1.7.1"
default['syslog-ng'][:archive] = "syslog-ng_#{node[:syslog-ng][:version]}.tar.gz"
default['syslog-ng'][:url] = "http://www.balabit.com/downloads/files/syslog-ng/sources/#{node['syslog-ng'][:version]}/source/#{node[:syslog-ng][:archive]}"
default['syslog-ng'][:patches] = nil
