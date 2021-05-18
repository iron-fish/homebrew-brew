URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-62dfc59.tar.gz".freeze
SHA = "42ac522fcb4869a451817124597b4fc0e9502f26656f37459f87fb98858c939e".freeze

class Ironfishbeta < Formula
  desc "Beta distribution of Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version "6"
  sha256 SHA
  license "MPL-2.0"
  version_scheme 1

  head "https://github.com/iron-fish/homebrew-brew.git"

  depends_on "node@14"

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/,
"export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@14"].bin}/node"

    mv "bin/ironfish", "bin/ironfishbeta"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfishbeta"
  end

  test do
    system bin/"ironfishbeta", "version"
  end
end
