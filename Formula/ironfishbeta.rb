URL = "https://ironfish-cli.s3.amazonaws.com/ironfish-cli-22e9f8c.tar.gz".freeze
SHA = "a32a35d4d2d6fdc970694926bfc4052c0598e0154f6495a10fc9301ae6e94717".freeze
VERSION = "68".freeze

class Ironfishbeta < Formula
  desc "Beta distribution of Iron Fish"
  homepage "https://ironfish.network/"
  url URL
  version VERSION
  sha256 SHA
  license "MPL-2.0"
  version_scheme 1

  head "https://github.com/iron-fish/homebrew-brew.git"

  depends_on "node@16"

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
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["node@16"].bin}/node"

    mv "bin/ironfish", "bin/ironfishbeta"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfishbeta"
  end

  test do
    system bin/"ironfishbeta", "version"
  end
end
