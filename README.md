# Ansible Playbook Template
Ansible configuration project template. Includes a barebones project framework, Ansible configuration, a Makefile, and tooling to wrap ansible-vault in git secret.


## Dependencies
* [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [git secret](https://git-secret.io/installation)


## Using This Template
1. Create a new repository using the contents of this repository
2. Prepare the vault secret for the first time (this only needs to be done once):


    dd if=/dev/urandom of=.vault_password count=20
    git secret tell <user@email.com>
    git secret add .vault_password
    git secret hide
    rm .vault_password
    make vault-encrypt


3. Run `make init` to install githooks.
4. Replace this README with `README.template.md` and customize to your needs.
5. Start building your roles, inventory, and variables.


## License
This project itself is licensed under the terms of the [MIT License](LICENSE).
Open-source projects or software contained within are copyright their respective authors.
