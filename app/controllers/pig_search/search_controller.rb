module PigSearch
  class SearchController < ::ApplicationController
    def search
      @results = Elasticsearch::Model.search(search_params[:query]).results
      @tags = get_tags_with_counts(@results)
      @results = filter_results_by_tag(@results, search_params[:filter]) if search_params[:filter].present?
    end

    private
    def search_params
      params.permit(:query, :filter)
    end

    def get_tags_with_counts(results)
      tags = results.flat_map(&:result_tags)
      tags.uniq.collect{|tag| [tag, tags.count(tag)]}
    end

    def filter_results_by_tag(results, tag)
      results.select{|result| result.result_tags.include?(tag)}
    end
  end
end
