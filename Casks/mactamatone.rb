cask "mactamatone" do
  version "0.1.0"
  sha256 "7e6010a77e80b404031ad730f2226f417eef16ce77a31f913b8b66c39d0d6231"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.1.0/Mactamatone_0.1.0_aarch64.dmg"
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
