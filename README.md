Ansible Playbook Template
=========================
Ansible configuration project template.


### Roles

##### Common
Performs base setup, including package installation, user management, and ssh configuration.


### Usage
A Makefile is included to simplify common tasks. Run `make help` to view available make targets. `make apply` updates all nodes in the inventory file.

```
Commands:

  apply             Update all nodes in the inventory file

  vault-open        Open the Ansible vault for editing in 'vim'
  vault-decrypt     Decrypt the Ansible Vault in-place
  vault-encrypt     Re-encrypt the Ansible Vault

  clean             Remove Ansible artifacts
```


### License
This project itself is licensed under the terms of the [MIT License](LICENSE).
Open-source projects or software contained within are copyright their respective authors.
