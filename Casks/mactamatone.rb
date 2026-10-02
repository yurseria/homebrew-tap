cask "mactamatone" do
  version "0.5.0"
  sha256 "108c42661446807e7ef53cfd03aed56d44ad9324e6d0fb3f82c5e00c377491df"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.5.0/Mactamatone_0.5.0_aarch64.dmg"
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
