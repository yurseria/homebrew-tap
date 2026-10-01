cask "mactamatone" do
  version "0.3.2"
  sha256 "4ac7aba54490d57478aa99544a23cfaa9cbe4072924279596a3c9844a32ef7a6"

  url "https://github.com/yurseria/mactamatone/releases/download/v0.3.2/Mactamatone_0.3.2_aarch64.dmg"
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
