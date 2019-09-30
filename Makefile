# Copyright (c) 2019 Winston Astrachan
#
# Ansible Playbook Makefile
#
SHELL=/bin/bash

.PHONY: help
help:
	@echo ""
	@echo "Usage: make COMMAND"
	@echo ""
	@echo "Ansible Playbook Makefile"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "  apply             Update all nodes in the inventory file"
	@echo ""
	@echo "  vault-open        Open the Ansible vault for editing in '$$EDITOR'"
	@echo "  vault-decrypt     Decrypt the Ansible Vault in-place"
	@echo "  vault-encrypt     Re-encrypt the Ansible Vault"
	@echo ""
	@echo "  clean             Remove Ansible artifacts"
	@echo ""

.vault_password:
	@echo ""
	@echo "Creating .vault_password file."
	@echo ""
	@echo " Supply the password for the Ansible Vault,"
	@echo " it will be saved in this file, and used on repeated runs:"
	@read -s VAULTPASSWORD; \
	echo "$$VAULTPASSWORD" > .vault_password;
	@echo ""

.PHONY: apply
apply: .vault_password
	ansible-playbook site.yml -i inventory -e 'ansible_ssh_user=root'

.PHONY: vault-open
vault-open: .vault_password
	@ansible-vault edit group_vars/vault.yml

.PHONY: vault-decrypt
vault-decrypt: .vault_password
	@ansible-vault decrypt group_vars/vault.yml

.PHONY: vault-encrypt
vault-encrypt: .vault_password
	@ansible-vault encrypt group_vars/vault.yml

.PHONY: clean
clean:
	find . -name "*.retry" -delete
	find . -name "*.log" -delete
