cask "netscope" do
  version "1.1.0"
  sha256 "f7408e7f51884c9c94d7e6cea5c7b1e8fe054814f1b94f79e8236599377fbe62"

  url "https://github.com/chinthalarohitho-alt/netscope/releases/download/v#{version}/Netscope-mac-arm64.dmg"
  name "Netscope"
  desc "Live network inspector for Android apps over adb"
  homepage "https://github.com/chinthalarohitho-alt/netscope"

  depends_on arch: :arm64
  depends_on :macos

  app "Netscope.app"

  # The app is ad-hoc signed, not notarized; clear the quarantine flag so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Netscope.app"],
        writable_paths: ["Netscope.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/Netscope",
    "~/Library/Preferences/io.github.chinthalarohitho-alt.netscope.plist",
    "~/Library/Saved Application State/io.github.chinthalarohitho-alt.netscope.savedState",
  ]

  caveats <<~EOS
    Netscope needs adb. If you don't have it:
      brew install --cask android-platform-tools
  EOS
end
