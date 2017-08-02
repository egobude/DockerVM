# avency Docker Development

## Start the machine

    vagrant up
    vagrant reload

## Docker Registry

The Docker Registry is located under https://docker-registry.avency.de:5000. 

| ------------- |-------------|
| Available Images | https://docker-registry.avency.de:5000/v2/_catalog |

## Edit your local /etc/hosts

    10.0.1.13 docker.dev

## Mount the NFS Share

The NFS share directory is located under /home/vagrant

    mkdir data
    sudo mount 10.0.1.13:/docker data

### Restart NFS

In some cases it could be necessary to restart the NFS service within the VM.

    vagrant ssh
    sudo /etc/init.d/nfs-kernel-server restart

## Pre installed docker containers

### Nginx Reverse Proxy

Nginx Reverse Proxy for Docker. More information here http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/

### Docker UI

Provides a web interface for docker. 

| ------------- |-------------|
| Url | http://docker.dev:9000 |
