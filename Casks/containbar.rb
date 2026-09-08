cask "containbar" do
  version "0.6.0"
  sha256 "ce3da75746e6d87dd028bc5c17369a42bc0a229d62d012eee454020bb209ebda"

  url "https://github.com/yurseria/containbar/releases/download/v0.6.0/Docker.Tray_0.6.0_aarch64.dmg"
  name "Containbar"
  desc "Manage Docker, Colima, and Apple containers from the menu bar"
  homepage "https://github.com/yurseria/containbar"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Docker Tray.app"

  caveats <<~EOS
    This app is not Developer ID signed or notarized.
    If macOS blocks it, open System Settings > Privacy & Security > Open Anyway
    only if you trust this app and its source. This cask does not bypass Gatekeeper.
    This release still installs Docker Tray.app; Containbar is its new name.
  EOS
end
