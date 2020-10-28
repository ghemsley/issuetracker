require_relative 'lib/issuetracker/version'

Gem::Specification.new do |spec|
  spec.name          = 'issuetracker'
  spec.version       = Issuetracker::VERSION
  spec.authors       = ['ghemsley']
  spec.email         = ['ghemsley@protonmail.ch']

  spec.summary       = 'A simple issue tracker'
  spec.description   = 'Helps you track issues when working on ruby code'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
