# encoding: UTF-8
#
# Cookbook Name:: rails_app_server
# Recipe:: install_ruby
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


include_recipe "ruby_build"
include_recipe "rbenv::system"
include_recipe "rbenv::vagrant" if node[:devops_base][:vagrant]

# OS Dendencies
%w(libpq-dev libxml2 libmysqlclient-dev libevent-dev zlib1g-dev liblzma-dev libxml2-dev libxslt-dev libpq5 mysql-common).each do |pkg|
  package pkg
end


rbenv_ruby node[:rails_app_server][:ruby_version] do
  action :install
end

rbenv_global node[:rails_app_server][:ruby_version]

rbenv_gem "bundler" do
  rbenv_version   node[:rails_app_server][:ruby_version]
  action          :install
end

# bash "automatic rbenv rehashing" do
#     code "git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash"
# end

# Add Github as known host
# ssh_known_hosts_entry 'github.com'
# ssh_known_hosts_entry 'bitbucket.org'
