require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'active_record'
require 'yaml'


task :default => :spec

RSpec::Core::RakeTask.new(:spec) do |t|
  ENV['test']
end

# desc "Run tests"
# Rake::TestTask.new do |t|
#   ENV['ENVIRONMENT'] = 'test'
#   t.libs << 'test'
# end
 
task :apidoc do
  `yardoc --api "apis"`
end

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
namespace "migrate" do
  task :production do
    db = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(db['production'])
    ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))

    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  task :development do
    db = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(db['development'])
    ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))

    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  task :test do
    db = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(db['test'])
    ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))

    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end