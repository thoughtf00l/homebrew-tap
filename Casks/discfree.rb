cask "discfree" do
  version "1.0.0"
  sha256 "5d10357e46d9412f8e1da248de3fd5c338f7ecb93a1764d61870114854b84a5c"

  url "https://github.com/thoughtf00l/discFree/releases/download/v#{version}/DiscFree.zip"
  name "DiscFree"
  desc "Disk-space analyzer with safe dev-junk cleanup"
  homepage "https://github.com/thoughtf00l/discFree"

  depends_on macos: ">= :sequoia"

  app "DiscFree.app"

  caveats <<~EOS
    DiscFree is not notarized. Install with --no-quarantine to avoid the
    Gatekeeper block:

      brew install --cask --no-quarantine discfree

    If already installed without it, clear the quarantine flag:

      xattr -d com.apple.quarantine /Applications/DiscFree.app

    Scanning protected folders (~/Library, Desktop, Documents) requires
    Full Disk Access: System Settings -> Privacy & Security -> Full Disk Access.
  EOS
end
