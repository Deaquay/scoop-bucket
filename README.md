# Deaquay's Scoop Bucket

[![Tests](https://github.com/Deaquay/scoop-bucket/actions/workflows/ci.yml/badge.svg)](https://github.com/Deaquay/scoop-bucket/actions/workflows/ci.yml) [![Excavator](https://github.com/Deaquay/scoop-bucket/actions/workflows/excavator.yml/badge.svg)](https://github.com/Deaquay/scoop-bucket/actions/workflows/excavator.yml)

A personal [Scoop](https://scoop.sh) bucket containing useful applications and utilities for Windows.

## 📦 Apps Available

| App | Version | Description |
|-----|---------|-------------|
| **freefilesync** | 14.5 | Folder comparison and synchronization software |
| **steamedit** | Latest | Steam library management and editing tool |

## 🚀 Installation

First, add this bucket to your Scoop installation:

```powershell
scoop bucket add deaquay https://github.com/Deaquay/scoop-bucket
```

Then install any app from the bucket:

```powershell
# Install FreeFileSync
scoop install deaquay/freefilesync

# Install SteamEdit
scoop install deaquay/steamedit
```

## 🔄 Updates

Manifests in this bucket support automatic updates via Scoop's built-in mechanisms:

```powershell
# Update all apps
scoop update *

# Update specific app
scoop update freefilesync
```

## 📋 Requirements

- **Windows 10/11** (64-bit recommended)
- **Scoop** package manager installed
- **PowerShell 5.1+** or **PowerShell Core 6+**

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork this repository
2. Create manifests following [Scoop's App Manifest guidelines](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
3. Test your manifests locally
4. Submit a pull request

For manifest creation help, check the [Contributing Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md).

## 📝 License

This bucket is licensed under the [Unlicense](LICENSE) - feel free to use it however you want.

---

**Note**: This bucket focuses on applications that may not be available in the main Scoop buckets or provides alternative packaging for existing tools.