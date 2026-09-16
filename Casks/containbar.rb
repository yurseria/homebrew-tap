cask "containbar" do
  version "0.6.1"
  sha256 "fd46a196ddd693b985d9ccb31ff93ad20df46040354b2785e43c8cd6da8a93a5"

  url "https://github.com/yurseria/containbar/releases/download/v0.6.1/Docker.Tray_0.6.1_aarch64.dmg"
  name "Containbar"
  desc "Manage Docker, Colima, and Apple containers from the menu bar"
  homepage "https://github.com/yurseria/containbar"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Docker Tray.app"

  caveats <<~EOS
    This app is not Developer ID signed or notarized.
    If macOS blocks it, open System Settings > Privacy & Security > Open Anyway
    only if you trust this app and its source. This cask does not bypass Gatekeeper.
    This release still installs Docker Tray.app; Containbar is its new name.
  EOS
end
