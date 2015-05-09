# encoding: UTF-8
#
# Cookbook Name:: rails_app_server
# Recipe:: setup_database
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

rbenv_script "rake_db_create_migrate_seed" do
  rbenv_version node[:rails_app_server][:ruby_version]
  cwd           node[:devops_base][:app_directory]
  code          "bundle exec rake db:create db:migrate db:seed"
  only_if { ::File.exists?(node[:devops_base][:app_directory] + "/Rakefile") && ::File.exists?(node[:devops_base][:app_directory] + "/config/database.yml") }
end
