module Rit
  class Repository
    attr_reader :worktree_path

    def initialize(worktree_path)
      @worktree_path = worktree_path
    end

    def self.create!(worktree_path)
      if worktree_path.exist?
        raise "#{worktree_path} is not directory" unless worktree_path.directory?
      else
        FileUtils.mkdir_p(worktree_path)
      end

      gitdir_path = worktree_path.join('.git')

      rerun = gitdir_path.exist?

      # .git/
      FileUtils.mkdir(gitdir_path) unless rerun
      # .git/objects/
      FileUtils.mkdir(gitdir_path.join('objects')) unless rerun
      # .git/refs/tags/
      FileUtils.mkdir_p(gitdir_path.join('refs/tags')) unless rerun
      # .git/refs/heads/
      FileUtils.mkdir_p(gitdir_path.join('refs/tags')) unless rerun

      # .git/description
      File.write(gitdir_path.join('description'), "Unnamed repository; edit this file 'description' to name the repository.\n") unless rerun

      # .git/config
      unless rerun
        config_path = gitdir_path.join('config')
        FileUtils.touch(config_path)
        config = Config.find!(config_path)
        config.set('core', 'repositoryformatversion', 0)
        config.set('core', 'filemode', false)
        config.set('core', 'bare', false)
        config.write
      end

      Repository.new(worktree_path)
    end
  end
end
