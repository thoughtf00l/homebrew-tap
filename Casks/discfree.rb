cask "discfree" do
  version "1.0.6"
  sha256 "1eae269de0ec406dfd4e19bf6026fbf3d157f1a08e69c2da2e4416ebf6f1e691"

  url "https://github.com/thoughtf00l/discFree/releases/download/v#{version}/DiscFree.zip"
  name "DiscFree"
  desc "Disk-space analyzer with safe dev-junk cleanup"
  homepage "https://github.com/thoughtf00l/discFree"

  deprecate! date: "2026-07-18", because: "it was renamed to stackdust", replacement_cask: "stackdust"

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
