# Codex Remote Community Launch Kit

Use this kit when introducing Codex Remote outside GitHub. Keep every post
linked to the canonical project home:

<https://github.com/codex-remote/codex-remote>

## Canonical facts

- Product: use an iPhone as a remote workbench for Codex running on a Mac.
- Current release: `0.2.0-beta.10`.
- Supported Runtime: Apple Silicon Mac, Homebrew, and Codex CLI `0.148.0+`.
- Verified client: iPhone Safari over a trusted LAN or a private Tailscale
  network; the remote path was exercised from iPhone 5G to the Mac Gateway.
- Distribution: third-party Homebrew Tap; binaries are unsigned and not Apple
  notarized.
- Transport: plain HTTP on a trusted LAN, or inside Tailscale's end-to-end
  encrypted WireGuard network; no public-internet Gateway endpoint.
- Source: independent Apache-2.0 repositories under the `codex-remote`
  organization.
- Independence: community project, not affiliated with or endorsed by OpenAI.

Do not describe the project as a remote desktop, cloud service, public Gateway,
production-ready release, signed application, or official OpenAI product.
Never publish a real pairing QR code or full pairing URL.

## One sentence

Codex Remote lets you follow and continue Mac-hosted Codex tasks from your
iPhone over local Wi-Fi or a private Tailscale network while execution and
project files stay on the Mac.

## Short English post

I open-sourced Codex Remote, a local-first remote workbench for Codex.

Start a task on an Apple Silicon Mac, then use iPhone Safari over local Wi-Fi or
a private Tailscale network to follow progress, send a follow-up, or review the
result. It is not a remote desktop: Codex and project files stay on the Mac.

The Beta installs through Homebrew, pairs with a one-time terminal QR code, and
includes health checks and repair tooling. The source is split into independent
Apache-2.0 repositories with versioned contracts.

Project and three-command quick start:
https://github.com/codex-remote/codex-remote

Tailscale Personal is currently free for personal use and avoids a fixed public
IP or router port forwarding. Current limits: Apple Silicon and iPhone Safari,
unsigned/unnotarized binaries, no public Gateway, and no TLS outside the
WireGuard tunnel.

## Show HN

Title:

```text
Show HN: Codex Remote - continue Codex on your Mac from your iPhone
```

Body:

```text
I built Codex Remote for the tasks that are long enough to leave my desk but
still need occasional follow-ups.

It runs Codex and keeps project files on an Apple Silicon Mac. An iPhone can
connect over the same Wi-Fi or a private Tailscale network, browse projects and
sessions, start or continue a task, and follow live status and results. It does
not stream the Mac screen or control the mouse and keyboard.

The public Beta installs with Homebrew and pairs through a one-time QR code.
The Runtime, SwiftUI client, React Mobile Web, Go Relay and Mac Agent, local
diagnostics platform, and architecture docs are all available under
Apache-2.0 in separate repositories.

The README includes a three-command quick start, screenshots, architecture,
source map, security limits, and roadmap:
https://github.com/codex-remote/codex-remote

Tailscale Personal is currently free for personal use and needs no fixed public
IP or router port forwarding. The current boundary remains narrow: Apple
Silicon, iPhone Safari, unsigned/unnotarized Beta, and no public Gateway. I
would especially value feedback on installation friction, private remote
pairing, and the mobile workflow.
```

## 中文短帖

```text
我把 Codex Remote 完整开源了：把 iPhone 作为运行在 Mac 上的 Codex 远程工作台。

你可以在 Apple Silicon Mac 上启动任务，然后通过同一可信局域网或 Tailscale 私有网络
中的 iPhone Safari 查看进度、继续对话或阅读结果。它不是远程桌面，不传输整个屏幕；
Codex 执行和项目文件始终留在 Mac 上。

当前 Beta 可以通过 Homebrew 安装，使用终端一次性二维码配对，并提供 doctor、repair、
升级和卸载流程。SwiftUI 客户端、React Mobile Web、Go Relay、Mac Agent、诊断平台和
架构文档都在独立仓库中采用 Apache-2.0 开源。

项目主页与三步快速开始：
https://github.com/codex-remote/codex-remote

Tailscale Personal 个人用途当前免费，不需要固定公网 IP 或路由器端口转发。当前边界
也写得很明确：仅 Apple Silicon 与 iPhone Safari，二进制尚未签名和公证，不提供普通
公网 Gateway。欢迎反馈安装、私有远程配对和手机工作流中的实际问题。
```

## Launch checklist

- Confirm the README, Formula, and latest release all name the same Runtime
  version.
- Link to `codex-remote/codex-remote`, not a component or packaging repository.
- Attach `assets/social-preview-v2.png` or a real redacted workflow recording.
- Keep the limitations visible in the initial post, not hidden in a reply.
- Test every command on a clean supported Mac before calling a release current.
- Remove pairing credentials, personal projects, private paths, and session
  content from screenshots and recordings.
- Use one post per community and answer concrete technical questions directly;
  do not cross-post identical promotional text into unrelated discussions.
