Vagrant.configure("2") do |config|
  # feed the monster
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.name = 'docker-vm'
  end

  # using ubuntu host
  config.vm.box = "ubuntu/trusty64"

  # use rsync to keep host in sync with guest VM
  config.vm.synced_folder "../", "/workspace",
    type: "virtualbox",
    rsync__exclude: [".git/", "node_modules/"]

  config.vm.provision:shell, :inline => 
    "apt-get update && apt-get -y install build-essential"
  # provision with docker and docker-compose
  config.vm.provision :docker
  # when running docker compose always rebuild and run
  config.vm.provision :docker_compose,
     yml: "/workspace/OdeToFood/docker-compose.yml",
     rebuild: true,
     run: "always"

  # don't automatically start syncing,
  # we'll kick that off in the startup script
  config.gatling.rsync_on_startup = false

  # forward ports
  config.vm.network 'private_network', ip: '192.168.33.11'
  config.vm.network :forwarded_port, guest: 4000, host: 4000 # service
end
