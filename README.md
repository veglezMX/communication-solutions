# Local Chat Stack Comparison

This repository contains local Docker Compose setups for Mattermost, Zulip, and Huly.

All checked-in example configuration uses dummy values for demo and comparison purposes only.

## Quick Start

1. Install Docker with the Compose plugin and `just`.
2. Run `just init` to create local runtime files from the checked-in examples.
3. Start one stack with `just mattermost`, `just zulip`, or `just huly`, or start everything with `just all`.

The service recipes also run `just init` first, so they are safe to use on a fresh clone.

## What `just init` creates

- `Huly/.env` from `Huly/.env.example`
- `mattermost/.env` from `mattermost/.env.example`
- `Zulip/.env` from `Zulip/.env.example`
- `Zulip/secrets/*.txt` from `Zulip/secrets/*.txt.example`

`just init` is idempotent and will not overwrite files that already exist.

## Local Access URLs

- Mattermost: `http://localhost:8065`
- Huly: `http://localhost:8087`
- Zulip: `https://localhost.localdomain:8443`

For Zulip, open the HTTPS URL directly and accept the browser warning for the self-signed certificate.

### Zulip First-Time Setup

A fresh Zulip server has no organization. After starting it, generate a one-time creation link:

```sh
just zulip-setup
```

This waits for the container to be healthy, then prints a URL. Open it in your browser to create your organization and admin account.

## Git Hygiene

Generated `.env` files and Zulip runtime secret files are ignored by git.
Only the example files are meant to be committed.