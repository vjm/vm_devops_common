source "https://supermarket.getchef.com"

# devops_base
cookbook 'devops_base', path: 'devops_base'
cookbook 'apt'
cookbook 'yum'
cookbook 'vim'

# postgres_data_server
cookbook 'postgres_data_server', path: 'postgres_data_server'
cookbook 'postgresql', '~> 3.4'

# rails_app_server
cookbook 'rails_app_server', path: 'rails_app_server'
cookbook 'ruby_build'
cookbook 'rbenv', git: "git@github.com:fnichol/chef-rbenv.git"
# cookbook 'nodejs_app_server', path: 'nodejs_app_server' # Uncomment this line if the nodejs_app_server is removed from this repository, as it's a dependency for rails_app_server.

# nodejs_app_server
cookbook 'nodejs_app_server', path: 'nodejs_app_server'
cookbook 'nodejs', '~> 2.4'
