#
# Cookbook Name:: sonar
# Recipe:: default
#
# Copyright 2011, Christian Trabold
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

package "unzip"

user node[:sonar][:user] do
  comment 'sonar Service Account'
  home    node[:sonar][:home_path]
  shell   '/bin/bash'
  supports :manage_home => true
  system  true
  action  :create
end

service "sonar" do
  supports :status => true, :restart => true, :start => true, :stop => true
end

include_recipe 'ark'
ark node[:sonar][:name] do
  url node[:sonar][:download_url]
  home_dir node[:sonar][:install_path]
  checksum node[:sonar][:checksum]
  version node[:sonar][:version]
  owner node[:sonar][:user]
  group node[:sonar][:group]
  notifies :restart, 'service[sonar]', :delayed
end

link "/etc/init.d/sonar" do
  to "/opt/sonar/bin/#{node[:sonar][:os_kernel]}/sonar.sh"
end

service "sonar" do
  action :enable
end

template "sonar.properties" do
  path "/opt/sonar/conf/sonar.properties"
  source "sonar.properties.erb"
  owner node[:sonar][:user]
  group node[:sonar][:group]
  mode 0644
  variables(
      :options => node[:sonar][:options]
  )
  notifies :restart, 'service[sonar]', :delayed
end

template "wrapper.conf" do
  path "/opt/sonar/conf/wrapper.conf"
  source "wrapper.conf.erb"
  owner node[:sonar][:user]
  group node[:sonar][:group]
  mode 0644
  notifies :restart, 'service[sonar]', :delayed
end

