
Vagrant.configure("2") do |config|

  config.vm.box = "debian/jessie64"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.network "forwarded_port", guest: 4000, host: 8080

end
