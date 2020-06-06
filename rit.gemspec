
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rit/version"

Gem::Specification.new do |spec|
  spec.name          = "rit"
  spec.version       = Rit::VERSION
  spec.authors       = ["natmark"]
  spec.email         = ["natmark0918@gmail.com"]

  spec.summary       = "rit is a git like version control system written in Ruby"
  spec.description   = "rit is a git like version control system written in Ruby"
  spec.homepage      = "https://github.com/natmark/rit"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "fakefs"

  spec.add_dependency "thor"
  spec.add_dependency "inifile"
end
