# Codex Remote

[![Latest release](https://img.shields.io/github/v/release/codex-remote/homebrew-tap?include_prereleases&label=runtime)](https://github.com/codex-remote/homebrew-tap/releases)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-0B6E4F.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Apple%20Silicon%20Mac-1F2937.svg)](#requirements)
[![GitHub stars](https://img.shields.io/github/stars/codex-remote/codex-remote?style=flat)](https://github.com/codex-remote/codex-remote/stargazers)

[简体中文](README.zh-CN.md) | [Install](#quick-start) | [Source code](#source-code) | [Roadmap](ROADMAP.md) | [Releases](https://github.com/codex-remote/homebrew-tap/releases)

![Codex Remote: use your phone as a remote workbench for Codex](assets/social-preview.png)

**Use your phone as a remote workbench for Codex running on your Mac.**

Start a long-running task on your Mac, then use your iPhone to follow its
progress, send a follow-up, or review the result. Codex and your project files
stay on the Mac. Codex Remote is not a remote desktop and does not stream your
screen or control your mouse and keyboard.

> [!WARNING]
> Codex Remote is pre-release software. The current public Beta is for Apple
> Silicon Macs and same-network iPhone Safari access. It is unsigned, not Apple
> notarized, and must not be exposed directly to the public internet.

## Quick start

### 1. Install the Runtime

```bash
brew trust --formula codex-remote/tap/codex-remote
brew install codex-remote/tap/codex-remote
```

### 2. Choose the projects available to your phone

```bash
codex-remote setup --workspace-root ~/work
```

### 3. Pair your iPhone

```bash
codex-remote pair
```

Scan the terminal QR code with your iPhone, choose a project and session, and
continue working. Treat the QR code and full pairing URL like a password: the
credential expires after 10 minutes by default and can be exchanged only once.

Run `codex-remote doctor` whenever setup, startup, or phone connectivity needs
diagnosis. Updates use the normal `brew upgrade codex-remote` flow.

## Product preview

<p align="center">
  <img src="assets/mobile-projects.png" alt="Codex Remote projects and sessions on an iPhone" width="360">
  <img src="assets/mobile-conversation.png" alt="A completed Codex task viewed on an iPhone" width="360">
</p>

The screenshots use sample projects and tasks. They contain no personal
workspace or session data.

## What you can do

- Browse the Codex projects and sessions available on your Mac.
- Start a task or continue an existing conversation from your phone.
- Follow live task status and read results as they arrive.
- Keep execution, project files, and persistent Runtime data on the Mac.
- Diagnose the local stack with one CLI instead of operating each service.

## How it works

![Codex Remote local-network architecture](assets/local-network-architecture.svg)

The phone connects to a Gateway on your Mac. The Gateway uses versioned HTTPS,
SSE, and WebSocket contracts to reach the Relay and Mac Agent; the Mac Agent
talks to Codex through the official App Server interface. The Runtime keeps its
own PostgreSQL and Valkey state and does not replace your existing databases.

## Requirements

- Apple Silicon Mac with macOS and [Homebrew](https://brew.sh/).
- Codex CLI `0.148.0` or later, installed and signed in. Runtime
  `0.2.0-beta.10` was verified through `codex-cli 0.154.0-alpha.6.2`.
- iPhone Safari on the same trusted local network as the Mac.
- A Mac that remains powered on, awake, and able to run Codex.

This Beta uses plain HTTP between the phone and Mac. Do not port-forward the
Gateway, publish it through a tunnel, or use it on an untrusted network. See the
[complete security and network model](https://github.com/codex-remote/homebrew-tap#security--network-model)
before installing.

## Source code

Codex Remote is open source under Apache-2.0. The project intentionally uses
independent repositories so each component can be built, tested, versioned, and
reviewed on its own.

| Repository | What it contains |
| --- | --- |
| [iphone-app](https://github.com/codex-remote/iphone-app) | Native SwiftUI iPhone client |
| [mobile-web](https://github.com/codex-remote/mobile-web) | React mobile client and same-origin Gateway |
| [relay-server](https://github.com/codex-remote/relay-server) | Relay, Run Server, Runtime authentication, and public contracts |
| [mac-agent](https://github.com/codex-remote/mac-agent) | Local Codex execution and workspace adapter |
| [admin-platform](https://github.com/codex-remote/admin-platform) | Local diagnostics server, collector, and Admin Web |
| [runtime-distribution](https://github.com/codex-remote/runtime-distribution) | Runtime CLI, supervisor, assembly, and release validation |
| [homebrew-tap](https://github.com/codex-remote/homebrew-tap) | Homebrew Formula, release artifacts, and detailed installation guide |
| [docs](https://github.com/codex-remote/docs) | Product, architecture, protocol, and ADR documentation |

Cross-repository integration happens through versioned contracts, schemas,
fixtures, and release manifests. The repositories do not use sibling source
imports, submodules, or symlink-based sharing.

## Build and contribute

Start in the repository that owns the component you want to change. Every code
repository documents its prerequisites, development command, focused tests,
and architecture boundary in its own README.

Read the organization [contribution guide](https://github.com/codex-remote/.github/blob/main/CONTRIBUTING.md)
before opening a pull request. Use [GitHub Discussions](https://github.com/codex-remote/codex-remote/discussions)
for product ideas and the owning repository's Issues for reproducible bugs.
Never attach pairing links, QR codes, credentials, private source, or unreviewed
diagnostic logs.

## Project status

The public Runtime is currently `0.2.0-beta.10`. Near-term work focuses on
signed and notarized distribution, stronger device management, broader real
device regression coverage, and a secure transport before any public-network
access is advertised. See the [Roadmap](ROADMAP.md) for the current boundary.

## License and independence

Current source code and future Runtime artifacts are licensed under the
[Apache License 2.0](LICENSE). Previously published Beta 1 through Beta 3
archives retain the license embedded in those immutable artifacts. See
[NOTICE](NOTICE) for attribution and project-name guidance.

Codex Remote is an independent community project. It is not affiliated with or
endorsed by OpenAI. Codex and OpenAI are trademarks of their respective owners.
