require 'bundler/gem_tasks'
Dir.glob('tasks/**/*.rake').each(&method(:import))

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r rails4-przelewy24.rb'
end
