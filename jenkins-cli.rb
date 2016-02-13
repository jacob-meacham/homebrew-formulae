class JenkinsCli < Formula
  desc "Install specified Jenkins CLI"
  homepage "https://github.com/jacob-meacham/homebrew-formulae"
  url "git@github.com:jacob-meacham/BLELib.git", :using => :git, :tag => "1.2.3"
  head "git@github.com:DopplerLabs/BLELib.git", :using => :git

  depends_on :java => "1.7+"

  def install
    libexec.install Dir["**/jenkins-cli.jar"]
    bin.write_jar_script libexec/"jenkins-cli.jar", "jenkins-cli"

  test do
    system "jenkins-cli", "--help"
  end
end
