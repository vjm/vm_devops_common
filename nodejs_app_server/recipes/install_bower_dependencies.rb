# encoding: UTF-8
#
# Cookbook Name:: nodejs_app_server
# Recipe:: install_bower_dependencies
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


bash "install_bower_dependencies" do
  # user "vagrant"
  cwd "/#{node[:devops_base][:app_name]}/client"
  # https://github.com/bower/bower/issues/1102#issuecomment-37298099
  code <<-EOH
bower install | xargs echo
EOH
  only_if { ::File.exists?("/#{node[:devops_base][:app_name]}/client/bower.json") }
end
