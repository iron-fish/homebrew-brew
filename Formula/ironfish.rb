require "formula"
require_relative "../lib/download_strategy"

URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-5d79ed9.tar.gz"
SHA = "68d245c2c23832a853b95c1efde5bbb69b5a8fdcc1b48dcea03673f4818b4a83"

class Ironfish < Formula
  desc "Everything you need to get started with Ironfish"
  homepage "https://github.com/iron-fish/homebrew-brew"
  head "https://github.com/iron-fish/homebrew-brew.git"
  depends_on "node@14"

  url URL
  sha256 SHA

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/, "export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@14"].bin}/node"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"
  end

  test do
    system bin/"ironfish", "version"
  end
end
