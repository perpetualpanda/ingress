.PHONY: install
install:
	uv sync
	uv run ansible-galaxy collection install bitwarden.secrets

.PHONY: deploy
deploy:
	uv run ansible-playbook main.yml -i inventory
