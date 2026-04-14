set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default: 
    just --list

init:
	@for file in Huly/.env mattermost/.env Zulip/.env; do \
		if [[ -f "$file" ]]; then \
			echo "Keeping $file"; \
		else \
			cp "$file.example" "$file"; \
			echo "Created $file"; \
		fi; \
	done
	@mkdir -p Zulip/secrets
	@for file in \
		zulip_postgres_password.txt \
		zulip_memcached_password.txt \
		zulip_rabbitmq_password.txt \
		zulip_redis_password.txt \
		zulip_secret_key.txt \
		zulip_email_password.txt; do \
		target="Zulip/secrets/$file"; \
		if [[ -f "$target" ]]; then \
			echo "Keeping $target"; \
		else \
			cp "$target.example" "$target"; \
			echo "Created $target"; \
		fi; \
	done

mattermost:
	just init
	cd mattermost && docker compose up -d

zulip:
	just init
	cd Zulip && docker compose up -d

zulip-setup:
	@echo "Waiting for Zulip to be ready..."
	@until docker exec zulip sh -c 'supervisorctl status | grep -q RUNNING' 2>/dev/null; do sleep 2; done
	@echo ""
	@docker exec zulip su zulip -c '/home/zulip/deployments/current/manage.py generate_realm_creation_link'

huly:
	just init
	cd Huly && docker compose up -d

all:
	just init
	cd mattermost && docker compose up -d
	cd Zulip && docker compose up -d
	cd Huly && docker compose up -d