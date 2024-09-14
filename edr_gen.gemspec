require_relative 'lib/edr_gen/version'

Gem::Specification.new do |spec|
  spec.name          = 'edr_gen'
  spec.version       = EdrGen::VERSION
  spec.authors       = ['Jason Loutensock']
  spec.summary       = 'A testing and logging tool for EDRs'

  spec.files         = Dir['lib/**/*', 'bin/*', 'Gemfile', 'README.md']
  spec.executables   = ['edr_gen']
  spec.require_paths = ['lib']

  # spec.add_dependency "i18n", "~> 1.8"  # Add dependencies as needed
end