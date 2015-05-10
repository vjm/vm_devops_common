# encoding: UTF-8
#
# Cookbook Name:: postgres_data_server
# Recipe:: default
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


default['postgresql']['password']['postgres'] = 'default_password'

default['postgresql']['config']['listen_addresses'] = '*'
default['postgresql']['pg_hba'] = [
    {:comment => '# Optional comment', :type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'trust'},
    {:comment => '# Optional comment', :type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'trust'},
    {:comment => '# Optional comment', :type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'trust'},
    {:comment => '# Optional comment', :type => 'host', :db => 'all', :user => 'all', :addr => '192.168.0.1/8', :method => 'trust'},
    {:comment => '# Optional comment', :type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'md5'}
]
