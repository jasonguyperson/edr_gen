require File.expand_path('lib/edr_gen/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'edr_gen'
  spec.version               = EDRGen::VERSION
  spec.authors               = ['Jason Loutensock']
  spec.summary               = 'A testing and mixins tool for EDRs'
  spec.files                 = Dir.glob("config/initializers/**") + Dir.glob("lib/**/*") + Dir.glob("bin/*")
  spec.executables           = ['edr_gen']
  spec.require_paths         = %w[lib]
  spec.required_ruby_version = '>= 3.3.0'
  spec.license               = nil
  spec.homepage              = 'https://github.com/jasonguyperson/edr_gen'

  # Dependencies
  spec.add_dependency 'sys-proctable', '~> 1.3'
  spec.add_dependency 'rainbow', '~> 3.0'
  spec.add_dependency 'yaml', '~> 0.1'
  spec.add_dependency 'httparty', '~> 0.19'
end
