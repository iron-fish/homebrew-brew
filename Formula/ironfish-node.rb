URL = "https://ironfish-cli.s3.amazonaws.com/node-14.16.0.tar.gz"
SHA = "6756b0fbf652c773e85993c904391bece2eb3d088bf926467a980c0ec34bacc8"

class IronfishNode < Formula
  desc "node.js dependency for ironfish"
  homepage "https://ironfish.network"

  url URL
  sha256 SHA

  def install
    share.install buildpath/"ironfish-node"
  end

  def test
    system bin/"ironfish-node", "version"
  end
end
