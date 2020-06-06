module Rit
  class Repository
    attr_reader :worktree_path

    def self.create!(worktree_path)
      if worktree_path.exist?
        raise "#{worktree_path} is not directory" unless worktree_path.directory?
      else
        FileUtils.mkdir_p(worktree_path)
      end

      gitdir_path = worktree_path.join('.git')

      re_init = gitdir_path.exist?

      # .git/
      FileUtils.mkdir(gitdir_path) unless re_init
      # .git/objects/
      FileUtils.mkdir(gitdir_path.join('objects')) unless re_init
      # .git/refs/tags/
      FileUtils.mkdir_p(gitdir_path.join('refs/tags')) unless re_init
      # .git/refs/heads/
      FileUtils.mkdir_p(gitdir_path.join('refs/heads')) unless re_init

      # .git/description
      File.write(gitdir_path.join('description'), "Unnamed repository; edit this file 'description' to name the repository.\n") unless re_init

      # .git/config
      unless re_init
        config_path = gitdir_path.join('config')
        FileUtils.touch(config_path)
        config = Config.load(config_path)
        config.set('core', 'repositoryformatversion', 0)
        config.set('core', 'filemode', false)
        config.set('core', 'bare', false)
        config.write
      end

      Repository.new(worktree_path)
    end

    def self.load(worktree_path)
      Repository.new(worktree_path) if worktree_path.exist?
    end

    def initialize(worktree_path)
      @worktree_path = worktree_path
    end
  end
end
