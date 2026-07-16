cask "seer" do
  version "0.1.0"
  sha256 "3c31d82a679e6fa8ab167571c874247ec92ffa4e2e8005bbac385936e9034420"

  url "https://github.com/thrtn70/seer/releases/download/v#{version}/Seer-#{version}.zip"
  name "Seer"
  desc "On-device inline autocomplete for any macOS text field"
  homepage "https://github.com/thrtn70/seer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Seer.app"

  # Un-notarized personal build: clear the quarantine flag so Gatekeeper doesn't block launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Seer.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/app.seer.agent.plist",
  ]
end
