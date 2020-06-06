require 'thor'
require 'pathname'
require 'rit/version'
require 'rit/repository'
require 'rit/config'

module Rit
  class Error < StandardError; end
  class Command < Thor
    desc 'version', 'print the version number'
    def version
      puts VERSION
    end

    desc 'init', 'Create an empty Git repository or reinitialize an existing one'
    option :path, desc: 'Where to create the repository.'
    def init
      path = Pathname(options[:path] || '.')
      rerun = path.exist?

      repository = Repository.create!(path)
      if rerun
        puts "Reinitialized existing Git repository in #{repository.worktree_path.expand_path}"
      else
        puts "Initialized empty Git repository in #{repository.worktree_path.expand_path}"
      end
    end
  end
end
