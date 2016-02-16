class JenkinsCli < Formula
  desc "Install Jenkins CLI"
  homepage "https://jenkins-ci.org"
  url "http://mirrors.jenkins-ci.org/war/1.647/jenkins.war"
  sha256 "52778609d34cb532c934509bb2a63c77986ae8e9b7e85186bad0235f58e4200f"

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    system "jar", "xvf", "jenkins.war"

    libexec.install Dir["**/jenkins-cli.jar"]
    bin.write_jar_script libexec/"jenkins-cli.jar", "jenkins-cli"

    if not ENV['JENKINS_URL']
      ohai 'JENKINS_URL environment variable is not set. Consider setting it to your most commonly used Jenkins instance.'
    end
  end

  test do
    system "jenkins-cli", "--help"
  end
end
