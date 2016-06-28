module PigSearch
  class SearchController < ::ApplicationController
    def search
      @results = Elasticsearch::Model.search(search_params[:query]).results
    end

    def search_params
      params.permit(:query)
    end
  end
end
