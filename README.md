# Ubuntu 16.04 LTS (Xenial) Ansible Test Image

[![Docker Automated build](https://img.shields.io/docker/automated/davidedimauro88/ubuntu1604-ansible.svg?maxAge=2592000)](https://hub.docker.com/r/davidedimauro88/ubuntu1604-ansible/)

Ubuntu 16.04 LTS (Xenial) Docker container for Ansible playbook, role and serverspec testing.

## Build the image

This image is built on Docker Hub automatically any time the upstream OS container is rebuilt, and any time a commit is made or merged to the `master` branch.
If you need to build the image on your local environment, do the following steps:

  1. Clone the repo `$ git clone git@github.com:darkraiden/docker-ubuntu1604-ansible`;
  2. `cd` into this directory;
  3. Run `$ docker build -t ubuntu-ansible .`.

## How to Use

  1. Pull this image from Docker Hub: `docker pull davidedimauro88/ubuntu1604-ansible:latest` or use the image's tag you built earlier, e.g. `ubuntu-ansible`;
  2. Run a container: `docker run -d --privileged davidedimauro88/ubuntu1604-ansible:latest /usr/lib/systemd/systemd` (To test an Ansible role, you may want to mount a volume with your role's directory as source and `/etc/ansible/roles/role_under_test` as destination on the container itself);
  3. Use Ansible inside the container:
    a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
    b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## Notes

This container is for test purposes only, I **do not** use it in a production environment. Use it on a live environment at your own risk!

## Author

Created in 2017 by [Davide Di Mauro](https://github.com/darkraiden).
