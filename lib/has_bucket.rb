require "has_bucket/version"
require "has_bucket/s3_config"
require "has_bucket/facade"

module HasBucket
  def self.of(url)
    config = S3Config.new(url)
    service = S3::Service.new(config.config)
    Facade.new(service, config.bucket)
  end
end
