class ChainCli < Formula
  desc "Command line tools for interacting with chain"
  homepage "https://github.com/jacob-meacham/chain-cli"
  url "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :tag => "0.1.0"
  head "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :branch => "develop"

  depends_on :python3

  resource "click" do
    url "https://pypi.python.org/packages/source/c/click/click-6.6.tar.gz"
    sha256 "cc6a19da8ebff6e7074f731447ef7e112bd23adf3de5c597cf9989f2fd8defe9"
  end

  include Language::Python::Virtualenv

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install_and_link buildpath

    bash_completion.install "contrib/bash/chain-complete.bash" => "chain"
  end

  test do
    system "chain", "--version"
  end
end
