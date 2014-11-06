require 'spec_helper'

describe HazBucket do
  it 'has a version number' do
    expect(HazBucket::VERSION).not_to be nil
  end

  let(:url) do
    'https://AKIAICVNTIM4AWNLWR4Q:or68aWn0XdYkU3ACrlBXQlTOnu2afAmhL0BkXfJe@' \
    's3.amazonaws.com/jma-2014-test-bucket'
  end

  let(:key) { "foo" }
  let(:value) { "bar" }

  subject { HazBucket.of(url) }

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
end
