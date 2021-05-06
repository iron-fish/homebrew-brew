URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-d2494c8.tar.gz".freeze
SHA = "4def977fe962c55d5b6156cbeb66dcd1f287373d7c016937c9d374a11a7f3f62".freeze

class Ironfishbeta < Formula
  desc "Beta distribution of Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version "4"
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
