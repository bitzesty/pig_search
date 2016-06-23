Rails.application.config.to_prepare do
  Pig::ContentPackage.class_eval do
    include PigSearch::Searchable

    private
    def result_title
      name
    end

    def result_path
      Pig::Engine.routes.url_helpers.content_package_path(self)
    end

    def result_tags
      taxonomy.collect(&:name)
    end
  end
end
