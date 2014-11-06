$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'haz_bucket'

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into "webmock"
  c.configure_rspec_metadata!
end

require "timecop"

RSpec.configure do |c|
  c.before(:each) do
    cassette = VCR.current_cassette
    Timecop.freeze(cassette.originally_recorded_at || Time.now) if cassette
  end

  c.after(:each) do
    Timecop.return
  end
end
