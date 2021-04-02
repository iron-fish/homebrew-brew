require "formula"
require_relative "../lib/download_strategy"

URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-2875cae.tar.gz"
SHA = "c55503b35a206f4799d619fc2ab0bbdf02c96dc328ee8aa83dfbc7d0e3a93c36"

class Ironfish < Formula
  desc "Everything you need to get started with Ironfish"
  homepage "https://github.com/iron-fish/homebrew-brew"
  head "https://github.com/iron-fish/homebrew-brew.git"
  depends_on "iron-fish/brew/ironfish-node"

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
