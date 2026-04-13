# Zulip Local Setup Summary

This Zulip stack was adjusted so it can run locally alongside Mattermost, Rocket.Chat, and Huly for comparison.

## Changes made

### 1. Host ports were moved off the defaults

Files affected:
- `.env`
- `docker-compose.yml`

Current local port mapping:
- HTTP: `8088 -> 80`
- HTTPS: `8443 -> 443`
- SMTP: `2525 -> 25`

Why this was necessary:
- The default Zulip ports (`80`, `443`, `25`) are awkward for running several chat products side by side on one machine.
- High host ports avoid conflicts with the other local comparison stacks.

### 2. `EXTERNAL_HOST` was changed to a dotted local hostname

File affected:
- `.env`

Current value:
- `ZULIP_EXTERNAL_HOST=localhost.localdomain:8443`

Why this was necessary:
- Zulip rejects values like `localhost:8088` because `EXTERNAL_HOST` must contain a domain part.
- `localhost.localdomain` is loopback-safe in this environment and satisfies Zulip's validation rules.

### 3. Self-signed TLS was enabled for local use

Files affected:
- `.env`
- `docker-compose.yml`

Current setting:
- `ZULIP_CERTIFICATES=self-signed`
- `CERTIFICATES: ${ZULIP_CERTIFICATES:-}` passed into the Zulip container

Why this was necessary:
- Zulip does not support being served directly over plain HTTP unless it is behind a trusted TLS-terminating reverse proxy.
- For this repo, Zulip is being used only for local comparison, so the smallest supported solution is to let the container generate and serve a self-signed certificate.
- This avoids having to set up a separate reverse proxy just for the local test environment.

Note:
- Browsers will show a certificate warning on first visit because the certificate is self-signed.

### 4. Docker secret files were created under `secrets/`

Files added:
- `secrets/zulip_postgres_password.txt`
- `secrets/zulip_memcached_password.txt`
- `secrets/zulip_rabbitmq_password.txt`
- `secrets/zulip_redis_password.txt`
- `secrets/zulip_secret_key.txt`
- `secrets/zulip_email_password.txt`

Why this was necessary:
- This Compose stack is configured to pass secrets through Docker secrets instead of plain environment variables.
- Without these files, the Zulip container and its dependency containers would fail to start because the declared secret mounts would be missing.

Important note:
- `zulip_email_password.txt` is only a placeholder in this local setup. Outbound email is not fully configured.

### 5. Initial organization setup was completed via a management command

Runtime action performed:
- A one-time organization creation link was generated using Zulip's `manage.py generate_realm_creation_link` command.

Why this was necessary:
- A fresh Zulip server has no organizations by default.
- Until an organization is created, the UI shows "No organization found" and cannot be used normally.

## Current local access URL

Use Zulip here:

- `https://localhost.localdomain:8443`

Recommended behavior:
- Open the HTTPS URL directly.
- Accept the self-signed certificate warning in the browser.

## Scope of these changes

These changes were made for local testing and comparison only.

For a more production-like deployment, Zulip should normally be placed behind a proper HTTPS reverse proxy or use a publicly trusted certificate instead of the local self-signed setup.