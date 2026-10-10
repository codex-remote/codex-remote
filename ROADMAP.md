# Codex Remote Roadmap

[简体中文](ROADMAP.zh-CN.md) | [Back to README](README.md)

This roadmap describes direction, not release dates or compatibility promises.
Items move only after implementation and real-device validation.

## Available now

- Apple Silicon macOS Runtime distributed through a third-party Homebrew Tap.
- iPhone Safari access over the same trusted LAN or a private Tailscale network
  to Mac-hosted Codex projects and sessions.
- Task submission, follow-ups, live status, results, one-time pairing, refresh,
  browser logout, repair, health checks, and explicit local-data purge.
- Independent Apache-2.0 source repositories with versioned integration
  contracts and public release manifests.

## Next reliability work

- Add supported CLI commands to list and revoke paired devices from the Mac.
- Improve concurrent-tab behavior while retaining replay protection.
- Expand clean-install, upgrade, rollback, uninstall, and real-device tests.
- Improve diagnostics for port conflicts, firewalls, and local-network routing.
- Release automatic `lan` / `tailscale` mode selection, online iOS device
  discovery, and MagicDNS pairing.

## Stable distribution gates

- Sign Runtime executables with Apple Developer ID and notarize artifacts.
- Complete license review and retain immutable manifests and checksums.
- Validate install, upgrade, rollback, diagnostics, and pairing on a clean Mac.
- Pursue official Homebrew distribution after the Runtime meets its policies.

## Not available today

- Intel, Windows, or Linux Runtime packages.
- A public internet endpoint without Tailnet identity, or TLS for that path.
- A stable compatibility or production support commitment.

Tailscale is the verified private remote path. Public access without device
identity still requires TLS, abuse controls, capacity, recovery, and operations
to be implemented and verified.
