URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-0b86026.tar.gz".freeze
SHA = "17818e46c94d42250b5ca2be4998b642515098686dc06c23c138b711505a740d".freeze

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version "3"
  sha256 SHA
  license "MPL-2.0"
  version_scheme 1

  head "https://github.com/iron-fish/homebrew-brew.git"

  depends_on "node@14"

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/,
"export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@14"].bin}/node"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"
  end

  test do
    system bin/"ironfish", "version"
  end
end
