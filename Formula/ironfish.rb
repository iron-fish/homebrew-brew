URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-4b3079f.tar.gz".freeze
SHA = "7118ecfc03568fbb24df075152c79be2c5809f26a7c1a68e55329de6bac7dd43".freeze
VERSION = "19".freeze

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version VERSION
  sha256 SHA
  license "MPL-2.0"
  version_scheme 1

  head "https://github.com/iron-fish/homebrew-brew.git"

  depends_on "node@16"

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/,
"export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@16"].bin}/node"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"
  end

  test do
    system bin/"ironfish", "version"
  end
end
