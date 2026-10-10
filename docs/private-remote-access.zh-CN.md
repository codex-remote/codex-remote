# 使用 Tailscale 从外面连接 Codex Remote

[English](private-remote-access.md) | [返回项目主页](../README.zh-CN.md)

Codex Remote 支持两条可信访问路径：同一局域网，或 Tailscale 私有网络。Tailscale
适合人在外面连接家里或办公室的 Mac，不需要固定公网 IP、路由器端口转发或云端
Codex 环境。

> [!IMPORTANT]
> 这是私有远程访问，不是把 Codex Remote 发布到普通公网。不要启用 Tailscale
> Funnel，也不要把 Gateway 端口映射到家庭路由器公网。

## 为什么推荐 Tailscale

- Tailscale Personal 当前对个人非商业用途免费。
- iPhone 和 Mac 之间使用 WireGuard 端到端加密。
- 通常自动建立点对点连接；无法直连时使用加密 DERP 中继。
- 家庭公网 IP 发生变化时不需要修改 Codex Remote。
- Codex、项目文件、PostgreSQL、Valkey 和凭据仍留在 Mac。

Tailscale 账号独立于 Codex 和 OpenAI 账号。请使用个人 Apple、GitHub、Google 或
Microsoft 身份创建 Personal Tailnet，并在两台设备登录同一账号。

## 前提

- 家里或办公室的 Apple Silicon Mac 已运行 Codex Remote。
- Mac 保持开机、联网并避免进入无法远程唤醒的深度睡眠。
- Mac 和 iPhone 均安装官方 Tailscale 客户端。
- iPhone 的 Tailscale VPN 显示为已连接。

官方下载：[Tailscale Download](https://tailscale.com/download)

## 当前公开 Beta 的连接步骤

Runtime `0.2.0-beta.10` 已支持通过显式 Origin 使用 Tailscale。

1. 在 Mac 查看 Codex Remote 当前 Gateway 端口：

   ```bash
   codex-remote status
   ```

2. 查看 Mac 的 Tailnet IPv4：

   ```bash
   /Applications/Tailscale.app/Contents/MacOS/Tailscale ip -4
   ```

3. 使用 Tailnet IP 和 Gateway 端口生成一次性二维码：

   ```bash
   codex-remote pair \
     --origin http://<TAILNET-IP>:<GATEWAY-PORT>
   ```

   例如：

   ```bash
   codex-remote pair --origin http://100.64.0.10:18774
   ```

4. 在 iPhone 关闭 Wi-Fi，只保留蜂窝网络。确认 Tailscale 已连接，然后扫描二维码。

配对链接默认 10 分钟过期且只能兑换一次。不要把二维码、完整链接或真实凭据放进
Issue、截图、日志或公开聊天。

## 自动模式选择

`runtime-distribution` 的当前源码已提供简化命令，将在下一次完成发布门禁的 Beta 中
进入 Homebrew Runtime：

```bash
codex-remote network tailscale
codex-remote pair
```

也可以只为一次配对指定模式：

```bash
codex-remote pair --network tailscale
```

该命令会自动检查 Tailscale 安装、登录、连接状态、MagicDNS 和在线 iOS 设备。一台
iPhone 或 iPad 时自动选择；多台时终端显示编号。自动化环境可以显式指定：

```bash
codex-remote pair --network tailscale --device iphone-14-pro
```

默认使用稳定的 MagicDNS 短名称。名称解析异常时可退回 Tailnet IP：

```bash
codex-remote pair --network tailscale --address ip
```

切回局域网：

```bash
codex-remote network lan
codex-remote pair
```

更换 Origin 后需要重新配对，因为浏览器 Cookie、IndexedDB 和原生客户端凭据都按
Origin 隔离。

## 验证连接

先在 iPhone Safari 打开：

```text
http://<TAILNET-IP>:<GATEWAY-PORT>/gateway/healthz
```

正常响应：

```json
{"contract_version":"run-server-v1","status":"ok"}
```

在 Mac 判断当前是直连还是中继：

```bash
/Applications/Tailscale.app/Contents/MacOS/Tailscale ping <IPHONE-TAILNET-IP>
```

- `via <公网地址>:41641` 表示点对点直连。
- `via DERP(hkg)` 等表示流量通过加密 DERP 中继。
- 两种路径都由 WireGuard 端到端加密，区别主要是延迟和吞吐。

检查本机网络条件和最近 DERP：

```bash
/Applications/Tailscale.app/Contents/MacOS/Tailscale netcheck
```

## 安全边界

- Tailscale 负责设备网络身份与加密通道。
- Codex Remote 的一次性配对、Access Token、Refresh Rotation 和 Scope 继续负责
  应用层授权。
- Gateway 是手机唯一入口；Run Server、Auth Control、PostgreSQL、Valkey 和 Mac
  Agent 内部接口不应暴露。
- 当前 URL 在 Tailnet 内使用 HTTP，互联网链路由 WireGuard 加密；这不等同于公开
  HTTPS 网站，也不应该通过 Funnel 发布。
- 建议用 Tailscale ACL 或 Grants 只允许自己的移动设备访问 Mac 的 Gateway 端口。

## 常见问题

### Tailscale 显示在线，但访问超时

确认 iPhone 顶部 VPN 已连接，Mac 没有睡眠，并先访问 `/gateway/healthz`。运行
`tailscale status` 和 `tailscale ping` 判断设备是否进入数据平面。

### MagicDNS 无法解析

先使用 Tailnet IPv4。确认 Tailnet 管理页已启用 MagicDNS，随后重新生成配对链接。

### 只能走 DERP

文本、状态和普通 Codex 输出通常仍可用。若延迟不可接受，先检查 UDP、防火墙和
`tailscale netcheck`；不要为了追求直连而把 Gateway 暴露到公网。

