$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pig_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pig_search"
  s.version     = PigSearch::VERSION
  s.authors     = ["Yoomee"]
  s.email       = ["developers@yoomee.com"]
  s.homepage    = "https://github.com/Yoomee/pig_search"
  s.summary     = "Search for Pig CMS using Elasticsearch"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency 'elasticsearch-model', '~> 2.0.1'
  s.add_dependency 'elasticsearch-rails', '~> 2.0.1'
  s.add_dependency 'haml'

  s.add_development_dependency "sqlite3"
end
