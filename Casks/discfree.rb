cask "discfree" do
  version "1.0.0"
  sha256 "5d10357e46d9412f8e1da248de3fd5c338f7ecb93a1764d61870114854b84a5c"

  url "https://github.com/thoughtf00l/discFree/releases/download/v#{version}/DiscFree.zip"
  name "DiscFree"
  desc "Disk-space analyzer with safe dev-junk cleanup"
  homepage "https://github.com/thoughtf00l/discFree"

  depends_on macos: :sequoia

  app "DiscFree.app"

  postflight do
    # The app is not notarized; clear the quarantine flag so Gatekeeper
    # does not block the first launch.
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/DiscFree.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    DiscFree is not notarized; this cask clears macOS quarantine on install
    so the app opens without a Gatekeeper prompt.

    Scanning protected folders (~/Library, Desktop, Documents) requires
    Full Disk Access: System Settings -> Privacy & Security -> Full Disk Access.
  EOS
end
