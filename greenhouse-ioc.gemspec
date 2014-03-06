# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "greenhouse-ioc.rb"

Gem::Specification.new do |s|

  s.name        = 'greenhouse-ioc'
  s.version     = GreenhouseIoc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-12-28'
  s.summary     = "Greenhouse - Inversion of Control"
  s.description = "Ruby's implementation of Inversion of Control pattern done in a neat way."
  s.authors     = ["Marcin Maciukiewicz"]
  s.email       = 'mm@csquirrel.com'
  s.homepage    = 'https://github.com/cSquirrel/greenhouse-ioc'
  s.license     = 'MIT'
  s.rubyforge_project = "nowarning"

  s.files       = `git ls-files -- lib/*`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
end