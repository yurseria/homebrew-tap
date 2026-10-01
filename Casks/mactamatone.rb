cask "mactamatone" do
  version "0.4.0"
  sha256 "9f559d71b2f1acc507473c7c0261c2c7f2a77645b89d02f1c632b24a97670ee4"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.4.0/Mactamatone_0.4.0_aarch64.dmg"
  name "Mactamatone"
  desc "Play an Otamatone using your MacBook lid angle"
  homepage "https://github.com/yurseria/mactamatone"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Mactamatone.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Mactamatone.app"],
        sudo:         false,
        must_succeed: false
  end

  caveats <<~EOS
    This app is not Developer ID signed or notarized.
    This cask removes its quarantine attribute after installation.
    Install it only if you trust this app and its source.
  EOS
end
