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
	@echo ""
	@echo "  bootstrap         Perform first-time setup on a host"
	@echo "                        usage: make bootstrap limit=testhost.com"
	@echo ""
	@echo "  update            Update hosts, optionally limited by 'limit'"
	@echo "                        usage: make update [limit=staging]"
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

.PHONY: bootstrap
bootstrap:
	ansible-playbook site.yml update.yml -i inventory.yml -l $(limit) -u root -e 'ansible_ssh_port=22'

.PHONY: update
limit:=all
update:
	ansible-playbook site.yml -i inventory.yml -l $(limit)
