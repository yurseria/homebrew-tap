cask "mactamatone" do
  version "0.3.0"
  sha256 "4552807805eadee307b1dbb0cfebcb33a8afcb790ea2df05746e0f4f893d708e"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.3.0/Mactamatone_0.3.0_aarch64.dmg"
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
