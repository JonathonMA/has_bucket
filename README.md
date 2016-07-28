# I Has a Bucket

[![Build Status](https://travis-ci.org/JonathonMA/has_bucket.svg?branch=master)](https://travis-ci.org/JonathonMA/has_bucket)

![I Has a Bucket](http://i1.kym-cdn.com/photos/images/newsfeed/000/000/026/lolrus.jpg)

Simple wrapper around single-bucket S3 storage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'has_bucket'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_bucket

### With ruby 1.8

`has_bucket` should work with ruby 1.8, but you'll need to ensure your bundle
includes a compatible version of the mime-types gem (< 2).

## Usage

```ruby
s3 = HasBucket.of("https://AWS_ACCESS_KEY:AWS_SECRET_ACCESS_KEY@s3.amazonaws.com/BUCKET_NAME")

s3.include?("key") # => false
s3["key"] = "value"
s3["key"] # => "value"
s3.include?("key") # => true
s3.delete("key")
s3.include?("key") # => false
s3.url_for("key") # => authenticated URL to object
```

## TODO

- [ ] select region based on hostname

## Contributing

1. Fork it ( https://github.com/JonathonMA/has_bucket/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
