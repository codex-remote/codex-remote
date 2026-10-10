# Codex Remote

[![Runtime：0.2.0-beta.10](https://img.shields.io/badge/runtime-0.2.0--beta.10-0B6E4F.svg)](https://github.com/codex-remote/homebrew-tap/releases/tag/v0.2.0-beta.10)
[![CI](https://github.com/codex-remote/codex-remote/actions/workflows/ci.yml/badge.svg)](https://github.com/codex-remote/codex-remote/actions/workflows/ci.yml)
[![许可证：Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-0B6E4F.svg)](LICENSE)
[![平台](https://img.shields.io/badge/platform-Apple%20Silicon%20Mac-1F2937.svg)](#运行要求)
[![GitHub Stars](https://img.shields.io/github/stars/codex-remote/codex-remote?style=flat)](https://github.com/codex-remote/codex-remote)

[English](README.md) | [快速开始](#快速开始) | [人在外面使用](docs/private-remote-access.zh-CN.md) | [开源代码](#开源代码) | [路线图](ROADMAP.zh-CN.md)

![Codex Remote：把手机作为 Codex 的远程工作台](assets/social-preview-v2.png)

**同一 Wi-Fi，或人在外面，都能继续家里或办公室 Mac 上的 Codex。**

Codex Remote 把 iPhone 变成适合 AI 编程任务的远程工作台。你可以查看项目与会话、
发起任务、继续对话、跟踪实时输出并检查结果。它不是远程桌面：不传输整个屏幕，代码、
工具链和执行环境始终留在你的 Mac。

> [!WARNING]
> 当前为未签名、未经过 Apple 公证的公开 Beta，仅支持 Apple Silicon Mac 和 iPhone
> Safari。远程访问必须使用私有 Tailscale 网络；不要做公网端口转发，也不要使用
> Tailscale Funnel 发布 Gateway。

## 两种访问方式

| 模式 | 适合场景 | 网络要求 |
| --- | --- | --- |
| 局域网模式 | 手机和 Mac 在家里或办公室的同一可信 Wi-Fi | 无额外账号，直接配对 |
| 私有远程模式 | 通勤、出差或离开工位后连接家里/办公室 Mac | 安装 Tailscale；Personal 个人用途当前免费 |

![Codex Remote 局域网与 Tailscale 私有远程访问架构](assets/access-modes-architecture.svg)

Tailscale 使用 WireGuard 加密手机和 Mac 之间的连接，不要求固定公网 IP、动态 DNS、
路由器端口转发或云端 Codex 环境。Codex Remote Runtime 和项目数据仍全部运行在 Mac。

## 快速开始

### 1. 安装 Runtime

```bash
brew trust --formula codex-remote/tap/codex-remote
brew install codex-remote/tap/codex-remote
```

### 2. 选择手机可以访问的项目目录

```bash
codex-remote setup --workspace-root ~/work
```

### 3. 选择网络并配对

同一局域网直接运行：

```bash
codex-remote pair
```

人在外面使用时，在 Mac 与 iPhone 安装并登录同一
[Tailscale Personal](https://tailscale.com/pricing) 账号，然后根据当前公开 Beta 的
[Tailscale 远程接入指南](docs/private-remote-access.zh-CN.md)生成 Tailnet 配对链接。

Runtime 源码已经加入自动模式选择，将在下一次完成发布门禁的 Beta 中提供：

```bash
codex-remote network tailscale
codex-remote pair
```

二维码中的凭证默认 10 分钟后过期，而且只能兑换一次。请把二维码和完整配对链接当作
密码保管。

## 产品界面

<p align="center">
  <img src="assets/mobile-projects.png" alt="iPhone 上的 Codex Remote 项目与会话" width="360">
  <img src="assets/mobile-conversation.png" alt="在 iPhone 上查看已完成的 Codex 任务" width="360">
</p>

截图使用通用示例项目和任务，不包含个人工作区或真实会话数据。

## 可以做什么

- 浏览 Mac 上允许访问的 Codex 项目和历史会话。
- 从手机发起任务，或继续已有对话。
- 实时查看任务状态、输出和最终结果。
- 在执行方向错误时中断任务。
- 让项目文件、凭据、数据库和 Codex 执行始终留在 Mac。
- 使用一个 CLI 完成 Setup、配对、健康检查、Repair 和升级。

## 安全模型

- 手机只访问 Mobile Web Gateway；Run Server、Auth Control、PostgreSQL、Valkey
  和 Mac Agent 内部接口保持隐藏。
- 一次性 Pairing Grant 建立设备会话；短期 Access Token 与轮换 Refresh Token
  负责后续访问。
- 局域网模式只适用于可信网络。
- Tailscale 模式通过 WireGuard 加密私有网络传输，但当前 URL 仍是 Tailnet 内 HTTP，
  不等同于公开 HTTPS 服务。
- Origin 从局域网地址切换为 Tailnet 地址后需要重新配对。

完整安装、安全、排障和卸载说明见
[Homebrew Tap 文档](https://github.com/codex-remote/homebrew-tap/blob/main/README.zh-CN.md)。

## 运行要求

- Apple Silicon Mac、macOS 和 [Homebrew](https://brew.sh/)；暂不支持 Intel。
- 已安装并登录 Codex CLI `0.148.0` 或更高版本。Runtime `0.2.0-beta.10` 已验证到
  `codex-cli 0.154.0-alpha.6.2`。
- iPhone Safari；其他移动设备和浏览器仍待完整验收。
- Mac 保持开机、联网、唤醒并能够运行 Codex。
- 远程模式需要 Mac 和 iPhone 安装官方 Tailscale 客户端并登录同一 Tailnet。

## 开源代码

Codex Remote 采用 Apache-2.0 开源，并保持独立仓库边界：

| 仓库 | 内容 |
| --- | --- |
| [iphone-app](https://github.com/codex-remote/iphone-app) | 原生 SwiftUI iPhone 客户端 |
| [mobile-web](https://github.com/codex-remote/mobile-web) | React 移动客户端与同源 Gateway |
| [relay-server](https://github.com/codex-remote/relay-server) | Relay、Run Server、Runtime Auth 与公开契约 |
| [mac-agent](https://github.com/codex-remote/mac-agent) | 本地 Codex 执行与工作区适配器 |
| [runtime-distribution](https://github.com/codex-remote/runtime-distribution) | Runtime CLI、Supervisor、组装与发布验证 |
| [homebrew-tap](https://github.com/codex-remote/homebrew-tap) | Homebrew 安装、发布产物与运维说明 |
| [docs](https://github.com/codex-remote/docs) | 产品、架构、协议与 ADR 文档 |

跨仓库集成只通过版本化契约、Schema、Fixture 和发布 Manifest 完成，不使用兄弟源码
导入、Git Submodule 或符号链接共享代码。

## 支持项目

如果 Codex Remote 对你的工作流有帮助，可以：

- 给这个仓库一个 Star，帮助其他本地优先的 AI 编程用户发现它。
- 在 [Discussions](https://github.com/codex-remote/codex-remote/discussions) 分享你的
  使用场景。
- 在对应组件仓库提交可复现 Issue 或 Pull Request。

不要上传真实配对二维码、完整配对链接、凭据、私有源码或未经检查的诊断日志。

## 项目状态

当前公开 Runtime 是 `0.2.0-beta.10`。Tailscale 私有远程链路已完成 iPhone 5G 到 Mac
Gateway 的真实验证；自动网络模式已进入 Runtime 源码，待下一 Beta 完成干净组件、
安装升级和真机配对发布门禁。当前边界见[路线图](ROADMAP.zh-CN.md)。

Codex Remote 是独立社区项目，与 OpenAI 没有关联或背书关系。Codex 和 OpenAI 是其
各自所有者的商标。
