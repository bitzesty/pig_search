require 'active_support/concern'
require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "pig-search"

    after_commit on: [:create] do
      delay.perform_document_index
    end

    after_commit on: [:update] do
      delay.update_document_index
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
    as_json.merge({search_title: search_title})
  end

  private
  def search_title
    (try(:title) || try(:name) || try(:description))
  end
end
