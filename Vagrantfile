Vagrant.require_version ">= 1.5"

# Include project secific variables
require './vagrant.rb'
include ProjectVars

# Change permissions of inventory file
File.chmod(0622, 'Ansible/Inventory')

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
# source: https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

if !which('ansible-playbook')
	unless Vagrant.has_plugin?("vagrant-winnfsd")
	  raise 'Missing vagrant plugin winnfsd: use "vagrant plugin install vagrant-winnfsd" to install';
	end
end

Vagrant.configure("2") do |config|
	config.vm.provider :virtualbox do |v|
		v.name = VM_NAME
		v.customize [
			"modifyvm", :id,
			"--name", VM_NAME,
			"--memory", MEMORY,
			"--cpus", CPUS,
			"--natdnshostresolver1", "on"
		]
	end

	config.vm.box = "ubuntu-trusty.box"
	config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
	config.vm.network :private_network, ip: IP
	config.ssh.forward_agent = true

	#############################################################
	# Ansible provisioning (you need to have ansible installed!)
	#############################################################
	if which('ansible-playbook')
		# For Mac and *nix users
		config.vm.provision "ansible" do |ansible|
			ansible.playbook = "Ansible/Playbook.yml"
			ansible.inventory_path = "Ansible/Inventory"
			ansible.limit = 'all'
			ansible.extra_vars = {
				ansible: {
					vmName: VHOST,
					ip: IP
				},
				isWindows: false
			}
		end
	else
		# For Windows users
		config.vm.provision :shell, path: "Ansible/windows.sh", args: ["Ansible/Playbook.yml", VHOST, IP], keep_color: true
	end

	config.vm.synced_folder "./", "/vagrant", type: "nfs"
end
