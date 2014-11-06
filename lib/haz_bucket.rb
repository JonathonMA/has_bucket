require "haz_bucket/version"
require "haz_bucket/s3_config"
require "haz_bucket/facade"

module HazBucket
  def self.of(url)
    config = S3Config.new(url)
    service = S3::Service.new(config.config)
    Facade.new(service, config.bucket)
  end
end
