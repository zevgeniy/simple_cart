# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require "simple_cart/version"

Gem::Specification.new do |s|
  s.name        = "simple_cart"
  s.version     = SimpleCart::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vladimir Vorobyov"]
  s.email       = ["sparrowpublic@gmail.com"]
  s.homepage    = "http://github.com/sparrow/simple_cart"
  s.summary     = "Simple cart"
  s.description = "Simple shopping cart"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "state_machine"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end