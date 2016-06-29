module PigSearch
  class SearchController < ::ApplicationController
    def search
      @results = Elasticsearch::Model.search(
        get_query_json(search_params[:query], search_params[:date])).results
      @tags = get_tags_with_counts(@results)
      @results = filter_results_by_tag(@results, search_params[:filter]) if search_params[:filter].present?
    end

    private
    def search_params
      params.permit(:query, :filter, :date)
    end

    def get_tags_with_counts(results)
      tags = results.flat_map(&:result_tags)
      tags.uniq.collect{|tag| [tag, tags.count(tag)]}
    end

    def filter_results_by_tag(results, tag)
      results.select{|result| result.result_tags.include?(tag)}
    end

    def get_query_json(query, date=nil)
      json = {
        "query" => {
          "match" => {
            "_all" => (query || "")
          }
        },
      }
      if date
        return json.merge({
          "sort" => {
            "updated_at" => {
              "order" => date
            }
          }
        })
      end
      json
    end

  end
end
