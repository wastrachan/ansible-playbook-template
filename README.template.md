# Ansible Playbook for PROJECT
Ansible infrastructure configuration for PROJECT.


## Dependencies
In order to use this project and make infrastructure changes you must have the following tools installed:

* [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [git secret](https://git-secret.io/installation)


## Usage
A Makefile is included to simplify common tasks. Run `make help` to view available make targets.

#### Initialize the Project
When you first checkout the project, run `make init` to set up the project and install certain git hooks.

#### Adding a Host
1. Create a Debian 10 (Buster) instance
2. Add your ssh key if it is not already present
3. Create any relevant DNS entries
4. Add the host to `inventory.yml`, including it in all relevant groups.
5. Run Ansible for the first time: `make bootstrap host=testhost.com`

#### Updating all Hosts
You can update all hosts in a single command: `make update-all`.

#### Updating a List of Hosts
You can update a single (or several) hosts by applying [limits](https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html). Pass a pattern in to `make update-some` to narrow your update.

    make update-some limit=redis                # Update all hots with the redis role
    make update-some limit=db3.testhost.com     # Update the host db3.testhost.com
    make update-some limit=nginx:&staging       # Update all nginx staging servers
    make update-some limit=percona:!prod        # Update all non-production database servers

## Execution on Remote Hosts
The `ansible` utility can be used to execute ad-hoc commands on remote hosts in inventory. The general format of the command:

    ansible <pattern> -a <command>
    ansible <pattern> -m <module> -a <command>

For example, to execute a reboot on all non-production databases:

    ansible 'percona:!prod' -a 'reboot'

Or to use the service module to restart gunicorn:

    ansible 'buzzsaw:&prod' -m service 'name=gunicorn state=restarted'

You can easily validate your pattern before running a command:

    ansible 'nginx:&staging' --list-hosts

Additional reference for ad-hoc commands [here](https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html).


## Roles
| Role | Description |
|------|-------------|
| `common` | Performs common host setup. Install packages, creates users, configures SSH, firewall rules, and OS defaults.


## License
This project itself is licensed under the terms of the [MIT License](LICENSE).
Open-source projects or software contained within are copyright their respective authors.
