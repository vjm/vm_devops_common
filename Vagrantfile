# -*- mode: ruby -*-
# vi: set ft=ruby :

aws_settings_file = "vagrant_aws_settings.yaml"
if File.exists? (aws_settings_file)
  aws_cfg = YAML.load_file(aws_settings_file)
else
  # Quick solution to prevent errors by default if this yaml file isn't created.
  aws_cfg = YAML.load_file(aws_settings_file+".example")
end

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Settings for launching in AWS
  config.vm.provider :aws do |aws, override|
    override.vm.box = "aws_dummy"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    aws.access_key_id = aws_cfg['user']['access_key_id']
    aws.secret_access_key = aws_cfg['user']['secret_access_key']
    aws.keypair_name = aws_cfg['user']['keypair_name']

    aws.region = aws_cfg['vm']['region']
    aws.ami = aws_cfg['vm']['ami']
    aws.instance_type = aws_cfg['vm']['instance_type']
    aws.tags = {
      'Name' => "VMDEVOPSCOMMON-vagrant-#{aws_cfg['user']['short_name']}",
      'Owner' => aws_cfg['user']['full_name'],
      'Environment' => "vagrant-#{aws_cfg['user']['short_name']}"
    }

    override.ssh.username = aws_cfg['vm']['username']
    override.ssh.private_key_path = aws_cfg['user']['private_key_path']
  end

  # Settings for launching in Virtualbox
  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = "chef/ubuntu-14.04"
    override.vm.network :private_network, type: "dhcp"
    override.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      cached_addresses = {}
      if cached_addresses[vm.name].nil?
        if hostname = (vm.ssh_info && vm.ssh_info[:host])
          vm.communicate.execute("/sbin/ifconfig eth1 | grep 'inet addr' | tail -n 1 | egrep -o '[0-9\.]+' | head -n 1 2>&1") do |type, contents|
            cached_addresses[vm.name] = contents.split("\n").first[/(\d+\.\d+\.\d+\.\d+)/, 1]
          end
        end
      end
      cached_addresses[vm.name]
    end

    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
  end

  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = "11.10" # lock to match opsworks

  # Enable Berkshelf for dependency management
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "Berksfile"

  # Enable managing hosts file on guests and host
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Chef custom JSON for VMs
  chef_json = {
    # nodejs: {
    #     version: "0.10.33",
    #     source: {
    #         checksum: "75dc26c33144e6d0dc91cb0d68aaf0570ed0a7e4b0c35f3a7a726b500edd081e"
    #     }
    # },
    # rails_app_server: {
    #     ruby_version: "2.1.4"
    # },
    # postgresql: {
    #     password: {
    #         postgres: "postgres_password_override"
    #     }
    # },
    devops_base: {
        vagrant: true,
        stack_name: "vagrant-#{aws_cfg['user']['short_name']}",
        app_directory: "/app"
    }
  }

  config.vm.define :postgres_data_server do |app|
    app.vm.hostname = 'postgres-data-server1'
    config.vm.provider :aws do |aws, override|
      aws.user_data = "#!/usr/bin/env bash\necho postgres-data-server1 >/etc/hostname\nhostname postgres-data-server1"
      aws.subnet_id = aws_cfg['vm']['app']['subnet_id']
      aws.security_groups = aws_cfg['vm']['app']['security_group_ids']
    end
    app.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "postgres_data_server::default"
      chef.json = chef_json
    end
  end

  config.vm.define :devops_base do |db|
    db.vm.hostname = 'vm-devops-base'
    config.vm.provider :aws do |aws, override|
      aws.user_data = "#!/usr/bin/env bash\necho vm-devops-base >/etc/hostname\nhostname vm-devops-base"
      aws.subnet_id = aws_cfg['vm']['data']['subnet_id']
      aws.security_groups = aws_cfg['vm']['data']['security_group_ids']
    end
    db.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "devops_base::default"
      chef.json = chef_json
    end
  end

  config.vm.define :nodejs_app_server do |db|
    db.vm.hostname = 'nodejs-app-server1'
    config.vm.provider :aws do |aws, override|
      aws.user_data = "#!/usr/bin/env bash\necho nodejs-app-server1 >/etc/hostname\nhostname nodejs-app-server1"
      aws.subnet_id = aws_cfg['vm']['data']['subnet_id']
      aws.security_groups = aws_cfg['vm']['data']['security_group_ids']
    end
    db.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "nodejs_app_server::default"
      chef.json = chef_json
    end
  end

  config.vm.define :rails_app_server do |db|
    db.vm.hostname = 'rails-app-server1'
    config.vm.provider :aws do |aws, override|
      aws.user_data = "#!/usr/bin/env bash\necho rails-app-server1 >/etc/hostname\nhostname rails-app-server1"
      aws.subnet_id = aws_cfg['vm']['data']['subnet_id']
      aws.security_groups = aws_cfg['vm']['data']['security_group_ids']
    end
    db.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "rails_app_server::default"
      chef.json = chef_json
    end
  end
end
