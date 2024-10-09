URL = "https://releases.ironfish.network/ironfish-cli-700c521.tar.gz".freeze
SHA = "b74325d6216fb17ddcd055f023b57b93ccca3f379d076ca5d6f5cd5b693a24d1".freeze
VERSION = "117".freeze

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version VERSION
  sha256 SHA
  license "MPL-2.0"
  version_scheme 1

  head "https://github.com/iron-fish/homebrew-brew.git"

  depends_on "node@18"

  def install
    if OS.linux?
      odie "Homebrew builds are not yet supported on Linux. " \
           "However, you can build from source by following the steps in our GitHub README: " \
           "https://github.com/iron-fish/ironfish#install"
    end

    if Hardware::CPU.arm?
      odie "Homebrew builds are not yet supported on M1/Apple Silicon. " \
           "However, you can build from source by following the steps in our GitHub README: " \
           "https://github.com/iron-fish/ironfish#install"
    end

    inreplace "bin/ironfish", /^CLIENT_HOME=/,
"export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}/ironfish-cli\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@18"].bin}/node"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"
  end

  test do
    system bin/"ironfish", "version"
  end
end
