class ChainCli < Formula
  desc "Command line tools for interacting with chain"
  homepage "https://github.com/jacob-meacham/chain-cli"
  url "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :tag => "0.3.0"
  head "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :branch => "develop"

  depends_on :python3

  resource "click" do
    url "https://pypi.python.org/packages/source/c/click/click-6.6.tar.gz"
    sha256 "cc6a19da8ebff6e7074f731447ef7e112bd23adf3de5c597cf9989f2fd8defe9"
  end

  resource "termcolor" do
    url "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz"
    sha256 "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b"
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
