class Ironfish < Formula
  desc "Everything you need to get started with Ironfish"
  homepage "https://ironfish.network"
  url "https://cli-assets.heroku.com/heroku-v7.47.0/heroku-v7.47.0.tar.xz"
  sha256 "a0b3d142d9c860c0fcce5dc7dfcd9f5f6ce68704e6809202874040aac8ef83c1"
  depends_on "heroku/brew/heroku-node"

  def install
    inreplace "bin/ironfish", /^CLIENT_HOME=/, "export IRONFISH_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    inreplace "bin/ironfish", "\"$DIR/node\"", "#{Formula["ironfish-node"].opt_share}/node"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ironfish"

    bash_completion.install "#{libexec}/node_modules/@ironfish-cli/plugin-autocomplete/autocomplete/brew/bash"
    zsh_completion.install "#{libexec}/node_modules/@ironfish-cli/plugin-autocomplete/autocomplete/brew/zsh/_ironfish"
  end

  def caveats; <<~EOS
    To use the Ironfish CLI's autocomplete --
      Via homebrew's shell completion:
        1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
            NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                  and called, either explicitly or via a framework like oh-my-zsh.
        2) Then run
          $ ironfish autocomplete --refresh-cache

      OR

      Use our standalone setup:
        1) Run and follow the install steps:
          $ ironfish autocomplete
  EOS
  end

  test do
    system bin/"ironfish", "version"
  end
end
