# Reach Codex Remote away from home with Tailscale

[简体中文](private-remote-access.zh-CN.md) | [Back to the product home](../README.md)

Codex Remote supports two trusted paths: the same local network, or a private
Tailscale network. Tailscale is the recommended way to reach a Mac at home or
the office without a fixed public IP, router port forwarding, or a cloud-hosted
Codex environment.

> [!IMPORTANT]
> This is private remote access, not a public Codex Remote endpoint. Do not use
> Tailscale Funnel or forward the Gateway port through your internet router.

## Why Tailscale

- Tailscale Personal is currently free for personal, non-commercial use.
- WireGuard encrypts traffic end to end between the iPhone and Mac.
- Devices normally connect peer to peer and fall back to an encrypted DERP
  relay when direct connectivity is unavailable.
- A changing home public IP does not change the Codex Remote configuration.
- Codex, projects, PostgreSQL, Valkey, and credentials remain on the Mac.

Your Tailscale account is separate from Codex and OpenAI. Create a Personal
tailnet with a personal Apple, GitHub, Google, or Microsoft identity and sign
in to the same tailnet on both devices.

Official download: [Tailscale Download](https://tailscale.com/download)

## Current public Beta

Runtime `0.2.0-beta.10` supports Tailscale through an explicit origin.

1. Read the current Gateway port:

   ```bash
   codex-remote status
   ```

2. Read the Mac's Tailnet IPv4:

   ```bash
   /Applications/Tailscale.app/Contents/MacOS/Tailscale ip -4
   ```

3. Generate a one-time pairing link with that IP and Gateway port:

   ```bash
   codex-remote pair \
     --origin http://<TAILNET-IP>:<GATEWAY-PORT>
   ```

4. Turn off iPhone Wi-Fi, keep cellular data and Tailscale connected, then scan
   the QR code.

Pairing links expire after 10 minutes by default and can be exchanged once.
Never publish a real QR code, complete pairing URL, or credential.

## Automatic access-mode selection

The current `runtime-distribution` source includes a simpler workflow that will
ship after the next Beta completes its release gates:

```bash
codex-remote network tailscale
codex-remote pair
```

A one-shot alternative does not change the saved mode:

```bash
codex-remote pair --network tailscale
```

The command checks the Tailscale installation, sign-in state, connection,
MagicDNS, and online iOS devices. One online iPhone or iPad is selected
automatically; several devices produce a numbered terminal choice. Automation
can select one explicitly:

```bash
codex-remote pair --network tailscale --device iphone-14-pro
```

MagicDNS is the default. Use the Tailnet IP as a fallback:

```bash
codex-remote pair --network tailscale --address ip
```

Return to local-network pairing with:

```bash
codex-remote network lan
codex-remote pair
```

Changing the origin requires pairing again because browser cookies, IndexedDB,
and native credentials are origin-scoped.

## Verify the path

Open this from iPhone Safari over cellular data:

```text
http://<TAILNET-IP>:<GATEWAY-PORT>/gateway/healthz
```

Expected response:

```json
{"contract_version":"run-server-v1","status":"ok"}
```

From the Mac, inspect direct versus relayed connectivity:

```bash
/Applications/Tailscale.app/Contents/MacOS/Tailscale ping <IPHONE-TAILNET-IP>
/Applications/Tailscale.app/Contents/MacOS/Tailscale netcheck
```

`via <public-address>:41641` means a direct peer-to-peer path. `via DERP(hkg)`
or another region means encrypted relay traffic. Both remain end-to-end
encrypted; latency and throughput are the practical differences.

## Security boundary

- Tailscale provides device network identity and the encrypted transport.
- Codex Remote pairing, access tokens, refresh rotation, and scopes still
  enforce application authorization.
- The Gateway is the only phone entrypoint. Run Server, Auth Control,
  PostgreSQL, Valkey, and internal Mac Agent interfaces remain hidden.
- The Tailnet URL currently uses HTTP inside the WireGuard tunnel. It is not a
  public HTTPS endpoint and must not be published with Funnel.
- Restrict the Gateway port to your mobile devices with Tailscale ACLs or
  Grants when your tailnet contains other users or devices.

The Mac must remain powered on, connected, and awake enough to run Codex.

