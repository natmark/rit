require 'spec_helper'
require 'fakefs/spec_helpers'

TEST_PATH = Pathname.new('/test')

RSpec.describe Rit::Repository do
  include FakeFS::SpecHelpers

  describe '.create!' do
    before do
      Rit::Repository.create!(TEST_PATH)
    end

    it 'should exist .git' do
      expect(TEST_PATH.join('.git').exist?).to be true
    end
  end
end
