cask "stackdust" do
  version "1.1.0"
  sha256 "acc5b9c830d064845db98897ae219fd727d2c99c0a3f979b0bfcb478c7139227"

  url "https://github.com/thoughtf00l/stackdust/releases/download/v#{version}/Stackdust-#{version}.zip"
  name "Stackdust"
  desc "Disk-space analyzer with safe dev-junk cleanup"
  homepage "https://stackdust.app/"

  # The app updates itself via Sparkle; brew upgrade skips it unless --greedy.
  auto_updates true
  depends_on macos: :sequoia

  app "Stackdust.app"

  postflight do
    # The app is not notarized; clear the quarantine flag so Gatekeeper
    # does not block the first launch.
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Stackdust.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    Stackdust is not notarized; this cask clears macOS quarantine on install
    so the app opens without a Gatekeeper prompt.

    Scanning protected folders (~/Library, Desktop, Documents) requires
    Full Disk Access: System Settings -> Privacy & Security -> Full Disk Access.

    Stackdust is the new name of DiscFree. It keeps the same bundle id, so
    settings and the Full Disk Access grant carry over; the old DiscFree.app
    can be removed with: brew uninstall --cask discfree
  EOS
end
