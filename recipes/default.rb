
remote_file ::File.join(node['syslog-ng'][:install_tmp_dir],node['syslog-ng'][:archive]) do
	source node['syslog-ng'][:url]
end

bash "extract-archive" do
	cwd node['syslog-ng'][:install_tmp_dir]
	code <<-EOF
tar zxvf #{node['syslog-ng'][:archive]}
EOF
end

if node['syslog-ng'][:patches]
	node['syslog-ng'][:patches].keys.sort.each do |patch|
		remote_file ::File.join(node['syslog-ng'][:install_tmp_dir],patch) do
			source node['syslog-ng'][:patches][patch][:source_url]
		end
		patch_file = ::File.join(node['syslog-ng'][:install_tmp_dir],patch)
		bash "apply-patch" do
			cwd ::File.join(node['syslog-ng'][:install_tmp_dir],"syslog-ng-#{node['syslog-ng'][:version]}")
			code "patch -p#{node['syslog-ng'][:patches][patch][:level]} <#{patch_file}; rm #{patch_file}"
		end
	end
end

bash "build-and-install" do
	cwd ::File.join(node['syslog-ng'][:install_tmp_dir],"syslog-ng-#{node['syslog-ng'][:version]}")
	code <<-EOF
yum install -qy eventlog-devel
./configure
make
make install
ldconfig
cd /
rm -rf #{::File.join(node['syslog-ng'][:install_tmp_dir],"syslog-ng-#{node['syslog-ng'][:version]}")}
rm #{::File.join(node['syslog-ng'][:install_tmp_dir],node['syslog-ng'][:archive])}

EOF
end