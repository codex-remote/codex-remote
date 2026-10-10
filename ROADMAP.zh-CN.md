# Codex Remote 路线图

[English](ROADMAP.md) | [返回 README](README.zh-CN.md)

本路线图表达方向，不承诺发布日期或兼容性。只有完成实现和真机验证后，事项才会进入
“已经可用”。

## 已经可用

- 通过第三方 Homebrew Tap 分发的 Apple Silicon macOS Runtime。
- 通过同一可信局域网，或 Tailscale 私有网络，从 iPhone Safari 使用 Mac 上的
  Codex 项目与会话。
- 任务提交、后续要求、实时状态、结果、一次性配对、凭证刷新、浏览器退出、修复、
  健康检查和明确的本地数据清理。
- 使用版本化集成契约和公开发布 Manifest 的独立 Apache-2.0 源码仓库。

## 下一步可靠性工作

- 提供从 Mac 查看和撤销已配对设备的正式 CLI 命令。
- 在保留重放防护的同时改进多标签并发行为。
- 扩展全新安装、升级、回滚、卸载和真机测试。
- 改进端口冲突、防火墙和局域网路由诊断。
- 发布自动 `lan` / `tailscale` 模式选择、在线 iOS 设备发现和 MagicDNS 配对。

## Stable 分发门槛

- 使用 Apple Developer ID 签名 Runtime，并完成 Apple 公证。
- 完成许可证审查，保留不可变的 Manifest 与校验和。
- 在干净 Mac 上验证安装、升级、回滚、诊断和配对。
- Runtime 满足 Homebrew 政策后再推进官方分发。

## 当前不支持

- Intel、Windows 或 Linux Runtime。
- 无需 Tailnet 身份的公共互联网端点或手机连接 TLS。
- 稳定兼容性或生产支持承诺。

Tailscale 是经过验证的私有远程访问路径。无需设备身份的公共互联网访问仍需完成
TLS、滥用控制、容量、恢复和运维验证后才会评估。
