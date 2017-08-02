# DockerVM

## Start the machine

    vagrant up
    vagrant reload

## Edit your local /etc/hosts

    10.0.1.10 docker.vm

## Mount the NFS Share

The NFS share directory is located under /home/vagrant

    mkdir data
    sudo mount 10.0.1.10:/docker data

### Restart NFS

In some cases it could be necessary to restart the NFS service within the VM.

    vagrant ssh
    sudo /etc/init.d/nfs-kernel-server restart