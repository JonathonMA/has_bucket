require "cgi"
require "uri"
require "s3"
require "mime/types"

module HasBucket
  class Facade
    def initialize(service, bucket_name)
      @service = service
      @bucket_name = bucket_name
    end

    def include?(key)
      object(key).exists?
    end

    def object_keys
      bucket.objects.map(&:key)
    end

    def prefixed_with(prefix)
      bucket.objects(:prefix => prefix).map(&:key)
    end

    def []=(key, content)
      s3_object = object(key)
      s3_object.acl = "private"
      s3_object.content_type = content_type_from_key(key)
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

    def content_type_from_key(key)
      if (mime_type = MIME::Types.of(key).find { |mime| !mime.obsolete? })
        mime_type.content_type
      else
        "application/octet-stream"
      end
    end
  end
end
