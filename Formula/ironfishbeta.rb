URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-c68dc2d.tar.gz".freeze
SHA = "0f10a1def5505dde2f85e8e5d733bf7fbfe4e8a95dca8d45524a4bd5664af4ed".freeze

class Ironfishbeta < Formula
  desc "Beta distribution of Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version "1"
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
