#
# Cookbook Name:: ucarp
# Recipe:: default
#
# Copyright 2012, Eric Heydrick
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

package "ucarp"

template "/etc/network/interfaces" do
  source "interfaces.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :vid =>  node['ucarp']['vid'],
    :vip =>  node['ucarp']['vip'],
    :netmask => node['ucarp']['netmask'],
    :password => node['ucarp']['password'],
    :advskew => node['ucarp']['master'] ? node['ucarp']['advskew'] : node['ucarp']['advskew'] + 99,
    :advbase => node['ucarp']['advbase'],
    :master => node['ucarp']['master'] ? 'yes' : 'no',
    :interface => node['ucarp']['interface']
  )
  notifies :restart, "service[networking]", :immediately
end

service "networking" do
  supports :restart => true
  action :nothing
end
