#
# Cookbook Name:: nginx
# Recipe:: http_stub_status_module
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012-2013, Riot Games
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

include_recipe 'ul-nginx::authorized_ips'

template 'nginx_status' do
  path "#{node['nginx']['dir']}/sites-available/nginx_status"
  source 'modules/nginx_status.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

nginx_site 'nginx_status'

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-http_stub_status_module']
