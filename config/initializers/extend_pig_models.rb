Rails.application.config.to_prepare do
  Pig::ContentPackage.class_eval do
    include PigSearch::Searchable
  end
end
