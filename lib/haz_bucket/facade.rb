require "cgi"
require "uri"
require "s3"

module HazBucket
  class Facade
    def initialize(service, bucket_name)
      @service = service
      @bucket_name = bucket_name
    end

    def include?(key)
      object(key).exists?
    end

    def []=(key, content)
      s3_object = object(key)
      s3_object.acl = "private"
      s3_object.content = content
      s3_object.save
    end

    def [](key)
      object(key).content
    end

    def url_for(key, expiring_at = Time.now + 3600)
      object(key).temporary_url(expiring_at)
    end

    def public_url_for(key)
      object(key).url
    end

    def delete(key)
      object(key).destroy
    end

    private

    def object(key)
      bucket.object(key)
    end

    def bucket
      @service.bucket(@bucket_name)
    end
  end
end
