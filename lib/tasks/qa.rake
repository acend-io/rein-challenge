# frozen_string_literal: true

namespace :qa do
  desc 'Execute Rubocop'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['-D']
  end

  desc 'Execute RSpec'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.verbose = false
  end
end

desc 'Run QA Suite'
task qa: :environment do
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  %w[rubocop spec].each do |task|
    Rake::Task["qa:#{task}"].invoke
  end
  elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "Time to run Full Suite: #{elapsed.round(3)} seconds."
end
