# Ansible Project Makefile
# Copyright (c) 2020 Winston Astrachan

SHELL=/bin/bash
VAULT_FILES = group_vars/all.yml \
              host_vars/testhost.com.yml

.PHONY: help
help:
	@echo ""
	@echo "Usage: make COMMAND"
	@echo ""
	@echo "Ansible Project Makefile"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "  init              Initialize the project, run this after clone"
	@echo "  vault-decrypt     Decrypt the Ansible Vault in-place"
	@echo "  vault-encrypt     Re-encrypt the Ansible Vault"
	@echo "  clean             Remove Ansible artifacts"
	@echo ""
	@echo "  bootstrap         Perform first-time setup on a host"
	@echo "                        usage: make bootstrap host=testhost.com"
	@echo ""
	@echo "  update-all        Update all hosts in the inventory file"
	@echo "  update-some       Update a selection of hosts using ansible's limit operator"
	@echo "                        usage: make update-some limit=staging"
	@echo ""


.PHONY: init
init:
	./scripts/init.sh

.PHONY: vault-decrypt
vault-decrypt:
	@ansible-vault decrypt $(VAULT_FILES)

.PHONY: vault-encrypt
vault-encrypt:
	@ansible-vault encrypt $(VAULT_FILES)
	@git add $(VAULT_FILES)

.PHONY: clean
clean:
	find . -name "*.retry" -delete
	find . -name "*.log" -delete

.PHONY: bootstrap
bootstrap:
	ansible-playbook site.yml update.yml -i inventory.yml -l $(host) -u root -e 'ansible_ssh_port=22'

.PHONY: update-all
update-all:
	ansible-playbook site.yml -i inventory.yml

.PHONY: update-some
update-some:
	ansible-playbook site.yml -i inventory.yml -l $(limit)
