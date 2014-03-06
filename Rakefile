# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "greenhouse_ioc/version.rb"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

task :package => [:test] do |t|
  `rm -f greenhouse-ioc-*.gem`
  `gem build greenhouse-ioc.gemspec`
end

task :publish => [:package] do |t|

  is_wc_clean=`git status`.include?("nothing to commit")

  if not is_wc_clean
    puts "\nERROR: Refusing to publish.\nWorking copy contains changes. Commit the changes or stash them.\n\n"
    return false
  end

  # Publish to rubygems.org and tag the repo
  `gem push greenhouse-ioc-#{Greenhouse::VERSION}.gem && git tag --message="Release version: #{Greenhouse::VERSION}" v_#{Greenhouse::VERSION}`
end

desc "Run tests"
task :default => :test