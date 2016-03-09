class LibAwsSdk < Formula
  url "https://github.com/awslabs/aws-sdk-cpp/archive/0.9.6.tar.gz"
  sha256 "2d26995974eb03b6ba6d26c32f9956e95d5a3d0db6b5fa149a2df7e4773112f4"
  homepage "http://aws.amazon.com/"

  option "with-s3",
         "Build s3 client"
  option "with-ec2",
         "Build ec2 client"
  option "with-custom-memory-management",
         "Build with custom memory management"

  depends_on "cmake" => :build

  def install
    clients = []
    clients << 'aws-cpp-sdk-s3' if build.with? "s3"
    clients << 'aws-cpp-sdk-ec2' if build.with? "ec2"

    args = std_cmake_args
    args << '-DCUSTOM_MEMORY_MANAGEMENT=' + build.with? "custom-memory-management" 1 else 0
    if clients.any?
      args << 'BUILD_ONLY=' + clients.join(';')
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end

  test do
    raise
  end

end
