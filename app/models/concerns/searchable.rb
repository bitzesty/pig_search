require 'active_support/concern'
require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "pig-search"

    # TODO: make callbacks async
    after_commit on: [:create] do
      perform_document_index
    end

    after_commit on: [:update] do
      update_document_index
    end

    after_commit on: [:destroy] do
      __elasticsearch__.delete_document if self.published?
    end
  end

  # Override this method on non-pig models that don't respond to 'published?'
  def perform_document_index
    __elasticsearch__.index_document if self.published?
  end

  # Override this method on non-pig models that don't respond to 'published?'
  def update_document_index
    __elasticsearch__.update_document if self.published?
  end

  def as_indexed_json(options={})
    as_json.merge({result_title: result_title, result_path: result_path,
                   result_tags: result_tags})
  end

  private

  def result_title
    raise NoMethodError.new("Override this method to return the title of your
                            object in search results")
  end

  def result_path
    raise NoMethodError.new("Override this method to return the path to your
                            object in search results")
  end

  # Optional: Override to return array of tag strings if object is taggable
  def result_tags
    ""
  end
end
