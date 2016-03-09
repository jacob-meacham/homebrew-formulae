class LibAwsSdk < Formula
  url "https://github.com/awslabs/aws-sdk-cpp/archive/0.9.6.tar.gz"
  sha256 "cf2dad62e50c5c5cff88a4ad959af3aa402aa7e8aa1692bdf807052c0fe4aeb9"
  homepage "http://aws.amazon.com/"

  @@allClients = ['access-management', 'acm', 'apigateway', 'autoscaling', 'cloudformation',
    'cloudfront', 'cloudhsm', 'cloudsearch', 'cloudtrail', 'codecommit', 'codedeploy', 'codepipeline',
    'cognito-identity', 'cognito-sync', 'config', 'datapipeline', 'devicefarm', 'directconnect',
    'ds', 'dynamobdb', 'ec2', 'ecr', 'ecs', 'elasticache', 'elasticbeanstalk', 'elasticfilesystem',
    'elasticloadbalancing', 'elasticmapreduce', 'elastictranscoder', 'email', 'es', 'events', 'firehose',
    'gamelift', 'glacier', 'iam', 'identity-management', 'importexport', 'inspector', 'iot', 'kinesis',
    'kms', 'lambda', 'logs', 'machinelearning', 'marketplacecommerceanalytics', 'mobileanalytics',
    'monitoring', 'opsworks', 'queues', 'rds', 'redshift', 'route53', 's3', 'sdb', 'sns', 'sqs',
    'storagegateway', 'sts', 'support', 'swf', 'transfer', 'waf', 'workspaces']

  @@allClients.each { |client|  option "with-#{client}", "Build with #{client} client"}

  option "with-custom-memory-management",
         "Build with custom memory management"

  depends_on "cmake" => :build

  def install
    clients = []
    @@allClients.each { |client|
      clients << "aws-cpp-sdk-#{client}" if build.with? client
    }

    custom_memory_management = (build.with? "custom-memory-management") ? 1 : 0

    args = std_cmake_args
    args << "-DCUSTOM_MEMORY_MANAGEMENT=#{custom_memory_management}"
    if clients.any?
      args << "-DBUILD_ONLY=#{clients.join(';')}"
    end

    mkdir "build" do
      system "cmake", *args, ".."
      system "make"
      system "make", "install"
    end

    mv lib/"mac/Release", lib/"aws"
  end

  test do
    raise
  end
end
