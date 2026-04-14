# Self-Hosted Collaboration Platforms — Feature Comparison

**Scope:** Evaluation for a 20-user self-hosted deployment where the team may modify the source code. Legal/licensing details are covered in the companion analysis; this document focuses on **features**.

> **TL;DR recommendation:** **Zulip** is the strongest fit for our use case. It's the only one of the three purpose-built around async topic-threaded conversations, has zero feature gates on the self-hosted version, uses a fully permissive Apache 2.0 license, and scales comfortably well beyond 20 users with minimal operational overhead. Huly and Mattermost are listed for completeness — each has legitimate strengths, but both come with trade-offs that matter for our scenario.

---

## At a glance

| Dimension | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| **Primary category** | Team chat (async-first) | Team chat (Slack-style) | All-in-one workspace (PM + chat + docs) |
| **License** | Apache 2.0 | MIT (Team Ed.) / Commercial (Enterprise) | EPL-2.0 |
| **Cost for 20 users (self-hosted)** | $0 (desktop/web) or ~$70/mo w/ mobile push | $0 on Entry (with caps) or ~$200/mo paid | $0 |
| **Feature gates in free tier** | None | Yes (SSO, history, compliance) | None |
| **Operational complexity** | Low | Low–Medium | High |
| **Source modification friendliness** | Excellent | Good (Team Ed. only) | Good (internal use) |
| **Best for** | Focused async team communication | Slack-replacement w/ DevOps bent | Consolidating PM + chat + docs |

---

## Messaging & conversations

| Feature | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| 1:1 and group direct messages | ✅ | ✅ | ✅ |
| Public/private channels | ✅ (called "streams") | ✅ | ✅ |
| **Topic-based threading** | ✅ **First-class — every message belongs to a topic** | ⚠️ Flat channels + optional thread replies | ⚠️ Channel-based, thread replies |
| Message editing/deletion | ✅ | ✅ | ✅ |
| Message reactions | ✅ | ✅ | ✅ |
| Formatted messages (Markdown) | ✅ Rich Markdown + LaTeX | ✅ Markdown | ✅ Rich editor |
| Code blocks w/ syntax highlighting | ✅ | ✅ | ✅ |
| Message drafts | ✅ | ✅ | ✅ |
| Scheduled messages | ✅ | ✅ (paid) | ⚠️ Limited |
| Unlimited message history | ✅ | ⚠️ **Entry caps at 10k messages** | ✅ |
| Powerful search | ✅ Operators, scoped to streams/topics | ✅ Basic; advanced in paid | ✅ |

### Why Zulip wins here

Zulip's **topic model** is the defining feature. Every message in a stream has a topic, which works like an email subject. This turns chat into something searchable, resumable, and async-friendly — you can scroll through conversations weeks later without the "what is this thread even about" problem that plagues Slack/Mattermost channels. For a distributed team working across time zones or jumping between projects, this is a genuine productivity unlock, not a cosmetic difference.

---

## Integrations & extensibility

| Feature | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| Native integrations | 100+ | 100+ | ~Limited (growing) |
| Incoming webhooks | ✅ | ✅ | ✅ |
| Outgoing webhooks / bots | ✅ | ✅ | ✅ |
| Slash commands | ✅ | ✅ | ⚠️ |
| Full REST API | ✅ Well-documented | ✅ Well-documented | ✅ Typed client |
| Bot framework | ✅ Python bot framework | ✅ | ⚠️ |
| Custom plugins | ⚠️ Via bots/API | ✅ Go plugin system | ✅ Platform SDK |
| **GitHub sync (bidirectional)** | ⚠️ Webhooks only | ⚠️ Webhooks only | ✅ **True bidirectional** |
| CI/CD notifications | ✅ | ✅ | ⚠️ |

Honest note: Huly's bidirectional GitHub sync is genuinely best-in-class if that specific workflow matters to your team. Mattermost has the deepest Go plugin ecosystem. Zulip's API and bot story is excellent for the 90% of integration needs.

---

## Authentication & access control

| Feature | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| Username/password | ✅ | ✅ | ✅ |
| Google / GitHub OAuth | ✅ | ✅ | ✅ |
| **SAML 2.0 SSO** | ✅ **Free** | ❌ Paid only | ⚠️ Via OIDC |
| **LDAP / AD sync** | ✅ **Free** | ❌ Paid only | ⚠️ Limited |
| OpenID Connect | ✅ | ✅ | ✅ |
| Multi-factor auth | ✅ | ✅ | ⚠️ |
| Granular roles/permissions | ✅ **Free** | ❌ Advanced in paid | ✅ |
| Guest users | ✅ | ✅ (paid consumes seat) | ✅ |

### This is where Zulip pulls ahead decisively

Zulip includes SAML, LDAP, and advanced role-based permissions **in the free self-hosted version with zero restrictions**. Mattermost locks these behind paid Enterprise tiers. If you ever plug this into a corporate identity provider — which you almost certainly will — this alone is worth thousands of dollars per year compared to Mattermost.

---

## Voice, video, and real-time collab

| Feature | Zulip | ⭐ Mattermost | Huly |
|---|---|---|---|
| Voice calls (1:1) | ⚠️ Via integrations (Jitsi, BBB, Zoom) | ✅ Built-in | ✅ Built-in |
| Group video calls | ⚠️ Via integrations | ✅ **Up to ~50 in Calls plugin** | ✅ |
| Screen sharing | ⚠️ Via integrations | ✅ | ✅ |
| Virtual office / spatial audio | ❌ | ❌ | ✅ |

Credit where it's due: if built-in voice/video is a hard requirement, Mattermost or Huly are stronger out of the box. Zulip delegates this to Jitsi/BigBlueButton/Zoom integrations, which works but adds a component to maintain. For 20 users, this is usually a minor inconvenience, not a blocker.

---

## Project management, docs, and beyond-chat features

| Feature | Zulip | Mattermost | ⭐ Huly |
|---|---|---|---|
| Issue tracker | ❌ | ⚠️ Via Boards plugin | ✅ **Core product** |
| Kanban boards | ❌ | ⚠️ Boards plugin | ✅ |
| Roadmaps / milestones | ❌ | ❌ | ✅ |
| Collaborative docs / wiki | ❌ | ⚠️ Via Playbooks | ✅ Notion-like editor |
| Time tracking | ❌ | ❌ | ✅ |
| CRM / HRM modules | ❌ | ❌ | ✅ |
| Calendar / team planner | ❌ | ❌ | ✅ |

This is Huly's home turf. If the team's real problem is *"we want to replace Jira + Notion + Slack with one thing"*, Huly is the only option of the three that actually attempts that. But recognize the trade-off: Huly is a jack-of-all-trades and its chat experience, while functional, isn't as refined as Zulip's or Mattermost's.

---

## Admin, operations, and scalability

| Dimension | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| Deployment options | Ubuntu/Debian, Docker, DigitalOcean, Render | Docker, Linux binary, K8s | Docker Compose, K8s |
| Required stack | PostgreSQL, Redis, RabbitMQ (bundled) | PostgreSQL or MySQL | MongoDB/Postgres + MinIO + Elasticsearch + Redis + 5–10 services |
| **Operational footprint (20 users)** | Low — single VM, ~2 GB RAM | Low — single VM, ~2 GB RAM | **Heavy — ~8+ GB RAM, many containers** |
| Backup/restore tooling | ✅ Well-documented scripts | ✅ Standard | ⚠️ Manual procedures |
| Upgrade story | ✅ Twice-yearly major releases, scripted upgrades | ✅ Quarterly releases | ⚠️ Frequent releases, manual migration steps |
| Multi-org/multi-tenant | ✅ | ✅ | ✅ |
| High availability option | ✅ | ✅ (paid) | ✅ |
| Data export / portability | ✅ Excellent | ✅ | ⚠️ Limited GUI migration |

### Why this matters more than it seems

For 20 users we don't need to optimize for scale — we need to optimize for **maintenance burden**. Zulip runs as essentially one process group on one VM and needs attention maybe twice a year for upgrades. Huly needs 5–10 containers, MongoDB, Elasticsearch, MinIO, and frequent version upgrades with migration steps. One of us will own that operational load forever.

---

## Mobile experience

| Feature | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| iOS app | ✅ | ✅ | ✅ |
| Android app | ✅ | ✅ | ✅ |
| Push notifications (free self-hosted) | ⚠️ Free for ≤10 users; $3.50/user/mo above | ⚠️ Free via Mattermost's service | ✅ |
| Desktop app (Win/Mac/Linux) | ✅ | ✅ | ✅ |
| Offline support | ✅ | ✅ | ⚠️ |

**The one place Zulip costs money for us:** if we want mobile push notifications for 20 users, it's ~$70/month. We should decide upfront whether that's worth it or whether desktop/web notifications are enough for our workflow.

---

## Source modification & customization

| Aspect | ⭐ Zulip | Mattermost | Huly |
|---|---|---|---|
| Repo accessibility | Public, single repo | Public, multiple repos | Public, multiple repos |
| Code readability | ✅ Actively maintained, tested | ✅ Go + React | ⚠️ Large, complex TypeScript monorepo |
| Language / stack | Python (Django) + TypeScript | Go + React | TypeScript (Node) + Svelte |
| Contribution-friendliness | ✅ 1,500+ contributors, friendly to PRs | ✅ Active | ✅ Active |
| License restrictions on mods | None (Apache 2.0) | Team Ed. free; Enterprise binary can't be modified | Must share modified files if redistributed (EPL-2.0) |
| Trademark restrictions | Cannot call fork "Zulip" | Must rebrand forks | Cannot call fork "Huly" |

Zulip's codebase is famously well-organized and documented — their contributor guide is often held up as an example of how to run an open-source project. If we ever want to patch something ourselves, Zulip is the one where we're least likely to regret it.

---

## Decision summary

### Pick **Zulip** if…
- ✅ We want the best **text-based team communication** experience, full stop
- ✅ We value async conversations that survive being read a week later
- ✅ We want SSO/LDAP/permissions without paying for them
- ✅ We want the lowest operational maintenance burden
- ✅ We may modify the source and want the most permissive license
- ⚠️ We're okay with integrating external voice/video (Jitsi/Zoom) instead of native
- ⚠️ We're okay with paying ~$70/mo if mobile push is a hard requirement

### Pick **Mattermost** if…
- ✅ We specifically want a Slack clone with familiar UX
- ✅ We want native voice/video/screen-share out of the box
- ✅ We need the Go plugin ecosystem or specific DevOps integrations
- ❌ We're willing to accept SSO/LDAP being paid-only
- ❌ We're willing to live with the 10k message history cap on Entry, or pay

### Pick **Huly** if…
- ✅ Our **real problem** is tool sprawl — we want to replace Jira + Notion + Slack in one shot
- ✅ Bidirectional GitHub sync with project management is a killer feature for us
- ✅ We have the ops capacity to run a 5–10 container stack
- ⚠️ We accept that the chat component is functional but not the main attraction

---

## Recommendation

**Deploy Zulip.** For 20 users doing focused async work, it's the best tool, the cheapest to run, the easiest to maintain, and the most permissively licensed of the three. The only cost decision is whether to pay for mobile push — and that's a decision we can defer until after we've validated the tool is a fit.

If, after using Zulip, we find we *also* need project management and docs in the same place, we can add a separate dedicated tool for that rather than trying to make one platform do everything.