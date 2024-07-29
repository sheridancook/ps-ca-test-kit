require_relative 'lib/psca/version'

Gem::Specification.new do |spec|
  spec.name          = 'psca_test_kit'
  spec.version       = PSCA::VERSION
  spec.authors       = ['Canada Health Infoway']
  spec.email         = ['standards@infoway-inforoute.ca']
  spec.date          = Time.now.utc.strftime('%Y-%m-%d')
  spec.summary       = 'PSCA Tests'
  spec.description   = 'PSCA Tests'
  spec.homepage      = 'https://github.com/AccessDigitalHealth/inferno-framework/psca-test-kit'
  spec.license       = 'Apache-2.0'
  spec.add_runtime_dependency 'inferno_core', '>= 0.4.37'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.2')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/AccessDigitalHealth/inferno-framework/psca-test-kit'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
