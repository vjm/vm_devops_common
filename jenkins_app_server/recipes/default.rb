#
# Cookbook Name:: jenkins_app_server
# Recipe:: default
#
# Copyright (C) 2014 Vince Montalbano
#
# All rights reserved - Do Not Redistribute
#

include_recipe "devops_base::default"

include_recipe "jenkins::master"
