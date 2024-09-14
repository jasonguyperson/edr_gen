require_relative 'lib/edr_gen/version'

Gem::Specification.new do |spec|
  spec.name                  = 'edr_gen'
  spec.version               = EDRGen::VERSION
  spec.authors               = ['Jason Loutensock']
  spec.summary               = 'A testing and logging tool for EDRs'
  spec.files                 = Dir['lib/**/*', 'bin/*', 'Gemfile', 'README.md']
  spec.executables           = ['edr_gen']
  spec.require_paths         = %w[lib]
  spec.required_ruby_version = '>= 3.3.0'

  # Dependencies
  spec.add_dependency "sys-proctable", "~> 1.3"
end
