# Yurseria Homebrew Tap

English / [한국어](README_KO.md)

Homebrew Casks for [Containbar](https://github.com/yurseria/containbar) and [Simple Note](https://github.com/yurseria/simple-note).

## Install

Requires Homebrew, macOS 13 or later, and Apple Silicon. Intel builds are not currently provided by this tap.

```sh
brew install --cask yurseria/tap/containbar
brew install --cask yurseria/tap/simple-note
```

`--cask` selects GUI application packages, rather than command-line formulae. Homebrew may ask you to trust this third-party source; review it before accepting.

Containbar v0.6.0 still ships as **Docker Tray.app**. The cask will follow the renamed bundle when a Containbar release is published. Simple Note installs **Note.app**. If you already installed the same app manually, back it up or move that app bundle out of Applications before installing; do not overwrite a running app or remove its settings.

## First launch: unsigned apps

These apps are not Developer ID signed or notarized. Homebrew installation does not make them Apple-verified. If macOS blocks the first launch, and you trust the release, use **System Settings → Privacy & Security → Open Anyway**. See [Apple's instructions](https://support.apple.com/en-us/102445).

This tap does not remove quarantine attributes or disable Gatekeeper. SHA-256 checks detect changed downloads; they do not replace signing or notarization. Managed Macs may prohibit exceptions.

## Update / uninstall

```sh
brew update
brew upgrade --cask yurseria/tap/containbar yurseria/tap/simple-note
brew uninstall --cask yurseria/tap/containbar
brew uninstall --cask yurseria/tap/simple-note
```

Uninstall removes the app bundle, not your documents or preferences.

## Maintenance

GitHub Actions checks both upstream latest stable releases every six hours and can also be run manually. It downloads each Apple Silicon DMG, computes SHA-256, verifies GitHub's digest when present, and commits the version/URL/checksum. No cross-repository secret is required. Missing assets during release packaging are retried on the next run; ambiguous assets or unknown names fail rather than being guessed. GitHub may suspend scheduled workflows after prolonged repository inactivity; run or re-enable the workflow if updates stop.

To refresh manually: `node scripts/update-casks.mjs` (Node.js 22+, optional `GH_TOKEN` for API rate limits).
