# frozen_string_literal: true

require "bundler/gem_tasks"
task default: %i[]

desc "Runs the test cases"

task :test do
  `ruby -Ilib:test test/test_*.rb --verbose`
end

task :rubocop do
  `bundle exec rubocop -A`
end
