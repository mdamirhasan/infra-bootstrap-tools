# Startup infra for small self-hosted project

This repository provides Ansible playbooks to set up a minimal infrastructure for a simple self-hosted application. Ideal for small hobby projects.

Features:
* docker-swarm
* Caddy
    * [Auth Portal](https://github.com/greenpau/caddy-auth-portal)
    * [Docker Proxy](https://github.com/lucaslorentz/caddy-docker-proxy)
* Private docker registery
* Portainer
* Prometheus 
* Graphana

## Articles and Tutorials

The article / tutorial are splited into sections. 
* **Introduction** -> What are the tools to use to manager infrastructure. Perfect to learn the basis.
* **How-tos** -> Good take away fron this project - Answers many questions you could encounter in the future
* **Main quest** -> Deploy the Infrastructure using Ansible, Terraform and Github Action
* **Deepening Understanding** -> learn more about each applicaton used in this setup (Portainer, Graphana, Caddy, etc.)

### Tools Introduction

* [ ] WIP: 📚 1: [What is **Terraform** and why you might need it.]()
* [X] 📚 2: [What is **Terraform Cloud** and why you might need it.](https://faun.pub/what-is-terraform-cloud-and-why-you-might-need-it-c9847fb8f6e6?sk=ee85423512f39030bb287a3f2a6623d3)
* [ ] WIP: 📚 3: [What is **Github Action** and why you might need it.]()
* [ ] WIP: 📚 4: [What is **Ansible** and why you might need it.]()
* [ ] WIP: 📚 5: [What is **Ansible AWX** and why you might need it.]()

### Learn the Tools

* [X] 🌍 [How to configure GitHub Environments with Terraform?](https://faun.pub/how-to-configure-github-environments-with-terraform-d2b76766547b?sk=b50616eed7da268d5a99c459fc9c57d5)
* [ ] 🏭 How to provision VM on Digital Ocean with Terraform?
* [ ] 🔏 How to create SSH keys with Terraform?
* [ ] 🗺️ How to create Ansible Inventory with Terraform?
* [ ] 👩 How to run an Ansible playbook using GitHub Action?

### Main Quest - Put it all together

* [X] 🧰 1: [Design and Test Ansible playbook with Vagrant](https://faun.pub/a-disposable-local-test-environment-is-essential-for-devops-sysadmin-af97fa8f3db0?sk=f2f0e3a6b4fe4215cec13019887b6302)
   * Example code [.articles/1_vagrant_101](.articles/1_vagrant_101)   
* [X] 🧰 2 [Experimenting on Docker Swarm with Vagrant and Ansible](https://faun.pub/experimenting-on-docker-swarm-with-vagrant-and-ansible-bcc2c79ba7c4?sk=1eac227cf3c9ec5dc5abbf06f38e92c3)
   * Example code [.articles/2_docker_swarm_101](.articles/2_docker_swarm_101)
* [ ] WIP: 🧰 3: [Automate Infrastructure provisionning with Ansible and Github action]()

### Learn about the applications used in this setup

* [ ] WIP: ☸️ 1: [What is Portainer and why you might need it.]()
* [ ] WIP: ☸️ 2: [What is Prometheus and why you might need it.]()
* [ ] WIP: ☸️ 3: [What is Caddy and why you might need it.]()

## Architecture

![](./diagrams/startup_infra_for_small_self_hosted_project.png)

## Handy tool chain

Wanna go fast? Too lazy to setup your local env?

Then use the the tools from a docker container. I included a simple toochain in this repository and usefull alias to use it.

Use common infrastructure tools in docker with:
* [docker_tools_alias.sh](./bin/docker_tools_alias.sh)

```
source ./bin/docker_tools_alias.sh
```

```
use dasb for ansible in docker
use dap for ansible-playbook in docker
use daws for awscli in docker
use dpk for packer in docker
use dtf for terraform in docker
use dbash for bash in docker
```

## Scale Up

With docker swarm and portainer it because easy to manager multiple nodes.

![](./diagrams/scaled_up_infra_for_small_self_hosted_project.png)
