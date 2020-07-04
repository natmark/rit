require 'spec_helper'
require 'fakefs/spec_helpers'

TEST_PATH = Pathname.new('/test')
SUBDIR_PATH = TEST_PATH.join('subdir')

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

  describe '.find' do
    context 'when repository is exist' do
      before do
        Rit::Repository.create!(TEST_PATH)
        FileUtils.mkdir_p(SUBDIR_PATH)
      end

      it 'found repository' do
        expect(Rit::Repository.find(SUBDIR_PATH)).not_to be nil
      end
    end

    context 'when repository is not exist' do
      before do
        FileUtils.mkdir_p(SUBDIR_PATH)
      end

      it 'found nil' do
        expect(Rit::Repository.find(SUBDIR_PATH)).to be nil
      end
    end
  end
end
