# encoding: UTF-8
#
# Cookbook Name:: mongo_data_server
# Recipe:: save_env_variables
#
#
# The MIT License (MIT)

# Copyright (c) 2015 Vince Montalbano

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

env_file = "/#{node[:devops_base][:app_name]}/.env"

file env_file do
    action :create_if_missing
end

mongo_password_line = "MONGO_PASSWORD=#{node['mongoql']['password']['mongo']}"
mongo_username_line = "MONGO_USERNAME=#{node['mongoql']['username']}"
mongo_host_line = "MONGO_HOST=#{node['mongoql']['host']}"

ruby_block "insert mongo password in env_file" do
  block do
    file = Chef::Util::FileEdit.new(env_file)
    file.insert_line_if_no_match(/MONGO_PASSWORD/, mongo_password_line)
    file.write_file
  end
end

ruby_block "insert mongo username in env_file" do
  block do
    file = Chef::Util::FileEdit.new(env_file)
    file.insert_line_if_no_match(/#{mongo_username_line}/, mongo_username_line)
    file.write_file
  end
end

ruby_block "insert mongo host in env_file" do
  block do
    file = Chef::Util::FileEdit.new(env_file)
    file.insert_line_if_no_match(/#{mongo_host_line}/, mongo_host_line)
    file.write_file
  end
end

