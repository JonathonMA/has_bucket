require "uri_config"

module HasBucket
  class S3Config < URIConfig::Config
    alias_method :access_key_id, :username
    alias_method :secret_access_key, :password

    def bucket
      path[1..-1]
    end

    def use_ssl
      uri.scheme == "https"
    end

    config :access_key_id, :secret_access_key, :use_ssl
  end
end
