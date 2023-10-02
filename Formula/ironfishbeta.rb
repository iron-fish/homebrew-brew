URL = "https://releases.ironfish.network/ironfish-cli-a584239.tar.gz".freeze
SHA = "eb20c4cfd9015ad06b2fe0a3b3f87c99c61ba411cae23aebd96d015fdec284ec".freeze
VERSION = "100".freeze

class Ironfishbeta < Formula
  desc "Beta distribution of Iron Fish"
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

    mv "bin/ironfish", "bin/ironfishbeta"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfishbeta"
  end

  test do
    system bin/"ironfishbeta", "version"
  end
end
