# frozen_string_literal: true

require_relative 'lib/statement_timeout/version'

Gem::Specification.new do |spec|
  spec.name        = 'statement_timeout'
  spec.version     = StatementTimeout::VERSION
  spec.authors     = ['Zeke Gabrielse']
  spec.email       = ['oss@keygen.sh']
  spec.summary     = 'Wrap an Active Record transaction or query in a local statement timeout.'
  spec.description = 'Wrap an Active Record transaction or query in a local statement timeout.'
  spec.homepage    = 'https://github.com/keygen-sh/statement_timeout'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.1'
  spec.files                 = %w[LICENSE CHANGELOG.md CONTRIBUTING.md SECURITY.md README.md] + Dir.glob('lib/**/*')
  spec.require_paths         = ['lib']

  spec.add_dependency 'rails', '>= 6.0'

  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'temporary_tables', '~> 1.0'
  spec.add_development_dependency 'sql_matchers', '~> 1.0'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg'
end
