cask "mactamatone" do
  version "0.5.1"
  sha256 "ee951f056f180bccfd75a379df1d9045a515326e96a16aa1b833ece1aa10215b"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.5.1/Mactamatone_0.5.1_aarch64.dmg"
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
