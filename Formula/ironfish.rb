VERSION = "1.14.0".freeze
NPM_URL = "https://registry.npmjs.org/ironfish/-/ironfish-#{VERSION}.tgz".freeze
NPM_SHA = "907295644713ab8ece8b9d0ad6fc6cf10f916e977db185d654ba3ca7109e59f9".freeze
GITHUB_URL = "https://github.com/iron-fish/ironfish/archive/refs/tags/v#{VERSION}.tar.gz"
GITHUB_SHA = "ec2a52a1129c86746bc0e422515e12ca1cce2994ae2656ad0652a1dafa6341b8"

require "language/node"

class Ironfish < Formula
  desc "Everything you need to get started with Iron Fish"
  homepage "https://ironfish.network/"
  url NPM_URL
  sha256 NPM_SHA
  license "MPL-2.0"
  version_scheme 2

  depends_on "rust" => :build
  depends_on "yarn" => :build
  depends_on "node@20"

  resource "source" do
    url GITHUB_URL
    sha256 GITHUB_SHA
  end

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec) - ["--build-from-source"]
    rm_f libexec/"lib/node_modules/ironfish/node_modules/" \
                 "@ironfish/rust-nodejs-darwin-arm64/ironfish-rust-nodejs.darwin-arm64.node"

    resource("source").stage do
      system "yarn"
      cp Dir["ironfish-rust-nodejs/*.node"], "#{libexec}/lib/node_modules/ironfish/node_modules/@ironfish/rust-nodejs"
    end

    inreplace libexec/"lib/node_modules/ironfish/bin/run", "env node", "env #{Formula["node@18"].bin}/node"

    bin.install_symlink libexec/"lib/node_modules/ironfish/bin/run" => "ironfish"
  end

  test do
    system bin/"ironfish", "-d=.", "wallet:create", "test"
  end
end
