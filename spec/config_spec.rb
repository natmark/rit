require 'spec_helper'
require 'fakefs/spec_helpers'

TEST_PATH = Pathname.new('/test')
CONFIG_PATH = TEST_PATH.join('config')

RSpec.describe Rit::Config do
  include FakeFS::SpecHelpers

  before :each do
    FileUtils.mkdir_p(TEST_PATH)
    FileUtils.touch(CONFIG_PATH)
  end

  describe '.load' do
    context 'when load empty file' do
      let(:config) { Rit::Config.load(CONFIG_PATH) }
      it 'sections.count should_eq 0' do
        expect(config.inifile.sections.count).to eq 0
      end
    end

    context 'when load config file' do
      let(:config) do
        ini = <<-EOS
        [core]
	    repositoryformatversion = 0
	    filemode = true
	    bare = false
	    logallrefupdates = true
        ignorecase = true
	    precomposeunicode = true
        [remote "origin"]
	    url = git@github.com:natmark/rit.git
	    fetch = +refs/heads/*:refs/remotes/origin/*
        EOS

        File.write(CONFIG_PATH, ini)
        Rit::Config.load(CONFIG_PATH)
      end

      it 'sections.count should_eq 2' do
         expect(config.inifile.sections.count).to eq 2
      end
    end
  end

  describe '#write' do
    context 'when set testvalue to config' do
      let(:config) { Rit::Config.load(CONFIG_PATH) }
      before do
        config.set('test', 'testvalue', 10)
        config.write
      end

      it 'testvalue should_eq 10' do
        expect(Rit::Config.load(CONFIG_PATH).inifile['test']['testvalue']).to eq 10
      end
    end
  end
end
