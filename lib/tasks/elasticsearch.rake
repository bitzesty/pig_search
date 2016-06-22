require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do
  namespace :import do
    task content_packages: 'environment' do
      Pig::ContentPackage.__elasticsearch__.create_index! force: true
      ENV['CLASS'] = 'Pig::ContentPackage'
      ENV['INDEX'] = 'pig-search'
      Rake::Task['elasticsearch:import:model'].invoke
    end
  end
end
