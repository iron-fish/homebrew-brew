URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-a596c5f.tar.gz".freeze
SHA = "6d8dfe9468eae825be6ddfce440b622c3ca69bb9e8dbeb42a29ad92b5af811f6".freeze

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version "2"
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
