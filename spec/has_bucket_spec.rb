require 'spec_helper'

describe HasBucket do
  it 'has a version number' do
    expect(HasBucket::VERSION).not_to be nil
  end

  let(:url) do
    'https://AKIAICVNTIM4AWNLWR4Q:or68aWn0XdYkU3ACrlBXQlTOnu2afAmhL0BkXfJe@' \
    's3.amazonaws.com/jma-2014-test-bucket'
  end

  let(:key) { "foo" }
  let(:value) { "bar" }

  subject { HasBucket.of(url) }

  it "should allow storage of blobs on S3", :vcr do
    subject.delete key
    expect(subject).to_not include(key)

    subject[key] = value
    expect(subject).to include(key)
    expect(subject[key]).to eq value

    read_data = Net::HTTP.get(URI subject.url_for key)
    expect(read_data).to eq value

    subject.delete key
    expect(subject).to_not include(key)
  end

  it "#prefixed_with should allow for directory-like keys", :vcr do
    subject["other/bar"] = "bar"
    subject["foo/bar"] = "bar"
    subject["foo/baz"] = "baz"

    expect(subject.prefixed_with("foo/")).to eq %w(
      foo/bar
      foo/baz
    )

    subject.delete "other/bar"
    subject.delete "foo/bar"
    subject.delete "foo/baz"
  end
end
