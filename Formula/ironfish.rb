require "formula"
require_relative "../lib/download_strategy"

URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-defc003.tar.gz"
SHA = "5e460cdfb261eb1d230515270341d867f1b12c85ec67c1fbf4c90c28f126f73d"

class Ironfish < Formula
  desc "Everything you need to get started with Ironfish"
  homepage "https://github.com/iron-fish/homebrew-brew"
  head "https://github.com/iron-fish/homebrew-brew.git"
  # depends_on "ironfish/brew/ironfish-node"

  url URL
  sha256 SHA

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/, "export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["ironfish-node"].opt_share}/node"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"
  end

  test do
    system bin/"ironfish", "version"
  end
end
