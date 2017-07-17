server '13.113.251.104', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/kohei/.ssh/id_rsa'