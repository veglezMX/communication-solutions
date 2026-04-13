set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default: 
    just --list

mattermost:
	cd mattermost && docker compose up -d

rocketchat:
	cd Rocket.Chat && docker compose up -d

zulip:
	cd Zulip && docker compose up -d

huly:
	cd Huly && docker compose up -d

all:
	cd mattermost && docker compose up -d
	cd Rocket.Chat && docker compose up -d
	cd Zulip && docker compose up -d
	cd Huly && docker compose up -d