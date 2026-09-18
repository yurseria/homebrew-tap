cask "simple-note" do
  version "0.13.1"
  sha256 "a2e9456a4fa54cc4f014607a3fa79b74ff35c2d7a26ac2ef03fe2c2ad79cf7cc"

  url "https://github.com/yurseria/simple-note/releases/download/v0.13.1/Note_0.13.1_aarch64.dmg"
  name "Simple Note"
  desc "Text and Markdown editor for focused writing"
  homepage "https://github.com/yurseria/simple-note"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Note.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Note.app"],
                   sudo: false
  end

  caveats <<~EOS
    This app is not Developer ID signed or notarized.
    This cask removes its quarantine attribute after installation.
    Install it only if you trust this app and its source.
  EOS
end
