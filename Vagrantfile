
startup_script = "
  add-apt-repository ppa:saltstack/salt
  apt-get update -y
  apt-get install salt-minion -y
  cp -rf /vagrant/salt/minion /etc/salt/minion
  service salt-minion restart
  rm -rf /vagrant/venv
  salt-call state.highstate
"

if ENV.has_key?('DO_TOKEN')
    Vagrant.configure('2') do |config|
      config.vm.hostname = 'dropletname.example.com'
      # Alternatively, use provider.name below to set the Droplet name. config.vm.hostname takes precedence.

      config.vm.provider :digital_ocean do |provider, override|
        override.ssh.private_key_path = ENV.fetch('RSA_PRIVATE_KEY_PATH')
        override.vm.box = 'digital_ocean'
        override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
        override.vm.synced_folder ".", "/vagrant", type: "rsync",
          rsync__exclude: ["nocommit.sh", "venv"]

        provider.token = ENV.fetch('DO_TOKEN')
        provider.image = 'ubuntu-14-04-x64'
        provider.region = 'nyc1'
        provider.size = '1gb'
      end
      startup_script += '
        echo "\n"
        echo "Visit http://$(curl -w "\n" http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address 2> /dev/null )/"

        echo "\n"
      '
      config.vm.provision :shell, inline: startup_script
    end

else
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_url = "ubuntu/trusty64"

    config.vm.network :forwarded_port, guest: 80, host: 8017
    config.vm.network :forwarded_port, guest: 443, host: 8143
    config.vm.network :forwarded_port, guest: 8080, host: 8187

    startup_script += '
      echo "\n"
      echo "Visit http://0.0.0.0:8017/admin"
      echo "\n"
    '
    config.vm.provision :shell, inline: startup_script
  end
end
