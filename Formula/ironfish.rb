URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-c4275d1.tar.gz".freeze
SHA = "6b2dc6fdb2c352523e7f3f1a4bbc6c20bf9b607790559c0789fc6faed2e7911b".freeze

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://github.com/iron-fish/homebrew-brew"
  url URL
  sha256 SHA
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
