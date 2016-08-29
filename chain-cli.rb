class ChainCli < Formula
  desc "Command line tools for interacting with chain"
  homepage "https://github.com/jacob-meacham/chain-cli"
  url "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :tag => "0.1.0"
  head "git@github.com:jacob-meacham/chain-cli.git", :using => :git, :branch => "develop"

  depends_on :python

  resource "click" do
    url "https://pypi.python.org/packages/source/c/click/click-6.6.tar.gz"
    sha256 "cc6a19da8ebff6e7074f731447ef7e112bd23adf3de5c597cf9989f2fd8defe9"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[click].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])

    bash_completion.install "contrib/bash/chain-complete.bash" => "chain"
  end

  test do
    system "chain", "--version"
  end
end
