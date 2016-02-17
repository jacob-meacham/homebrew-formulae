class JenkinsCli < Formula
  desc "Install Jenkins CLI"
  homepage "https://jenkins-ci.org"
  url "http://mirrors.jenkins-ci.org/war/1.647/jenkins.war"
  sha256 "52778609d34cb532c934509bb2a63c77986ae8e9b7e85186bad0235f58e4200f"

  bottle :unneeded

  depends_on :java => "1.7+"

  option "with-ssh-keyfile", "If specified, the run script will by default look for ssh keys at JENKINS_SSH_KEYFILE."

  # modified from http://www.rubydoc.info/github/Homebrew/homebrew/Pathname:write_jar_script
  def write_jar_script(target_jar, script_name, java_opts = "", ssh_keyfile = false)
    mkpath
    (self+script_name).write <<-EOS.undent
      #!/bin/bash
      exec java #{java_opts} -jar #{target_jar} #{ssh_keyfile ? '-i ${JENKINS_SSH_KEYFILE}' : ''} "$@"
    EOS
  end

  def install
    system "jar", "xvf", "jenkins.war"

    libexec.install Dir["**/jenkins-cli.jar"]
    write_jar_script(libexec/"jenkins-cli.jar", "jenkins-cli", "", build.with?("ssh-keyfile"))

    if not ENV['JENKINS_URL']
      ohai 'JENKINS_URL environment variable is not set. Consider setting it to your most commonly used Jenkins instance.'
    end

    if build.with? "ssh-keyfile"
      ohai 'Set your SSH key at JENKINS_SSH_KEYFILE'
    end
  end

  test do
    system "jenkins-cli", "--help"
  end
end
