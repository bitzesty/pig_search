require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do
  namespace :import do
    task content_packages: 'environment' do
      Pig::ContentPackage.__elasticsearch__.create_index! force: true
      Pig::ContentPackage.import
    end
  end
end
