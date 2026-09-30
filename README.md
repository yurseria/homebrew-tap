# Yurseria Homebrew Tap

English / [한국어](README_KO.md)

Homebrew Casks for [Containbar](https://github.com/yurseria/containbar), [Simple Note](https://github.com/yurseria/simple-note), and [Mactamatone](https://github.com/yurseria/mactamatone).

## Install

Homebrew and an Apple Silicon Mac are required. Containbar and Simple Note support macOS 13 or later; Mactamatone requires macOS 14 or later.

```sh
brew install --cask yurseria/tap/containbar
brew install --cask yurseria/tap/simple-note
brew install --cask yurseria/tap/mactamatone
```

Containbar currently installs `Docker Tray.app`, Simple Note installs `Note.app`, and Mactamatone installs `Mactamatone.app`. If you installed one manually, quit it and move the old bundle out of Applications before installing its cask.

## Signing and first launch

These apps are not Developer ID signed or notarized. The casks verify each download's SHA-256 checksum and remove the installed app's quarantine attribute in a postflight step. A checksum does not replace Apple signing or notarization. Install these apps only if you trust their source and this tap.

## Update and uninstall

```sh
brew update
brew upgrade --cask yurseria/tap/containbar yurseria/tap/simple-note yurseria/tap/mactamatone
brew uninstall --cask yurseria/tap/mactamatone
```

Uninstalling a cask removes its app bundle, not your documents or preferences.

## Maintenance

GitHub Actions checks each upstream repository's latest stable release every six hours. It downloads the Apple Silicon DMG, verifies its size and GitHub digest when available, computes SHA-256, and updates the cask. A missing asset is retried on the next run; unexpected names or ambiguous assets fail rather than being guessed. The workflow can also be run manually. To refresh locally, run `node scripts/update-casks.mjs` with Node.js 22 or later.
