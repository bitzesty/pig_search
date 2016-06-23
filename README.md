# pig_search

pig_search is a Rails engine that adds search functionality to the [Pig](https://github.com/Yoomee/pig) CMS.

## Setup
Add pig_search to your Gemfile:
```
gem 'pig_search', git: 'https://github.com/yoomee/pig_search.git', tag: '0.0.1'
```
Mount the engine on a suitable path by adding it to your `config/routes.rb` file above where you mount the Pig engine:
```
mount PigSearch::Engine => "/search"
```
Create the elasticsearch index and add any existing Pig content packages with:
```
bundle exec rake elasticsearch:import:content_packages
```

## Adding custom models to index
By default pig_search only indexes the `Pig::ContentPackage` models, and specifically only those that are published.

To make your model searchable you must include the `PigSearch::Searchable` concern and add `result_title` and `result_path` instance methods to your model. There is also an optional `result_tags` method you can add if your model has tags. For example:
```ruby
include PigSearch::Searchable

private
# return a string of how your object will appear in search results
def result_title
  name
end

# return a path to your object that can be linked from search results
def result_path
  Pig::Engine.routes.url_helpers.content_package_path(self)
end

# return an array of strings
def result_tags
  taxonomy.collect(&:name)
end
```
