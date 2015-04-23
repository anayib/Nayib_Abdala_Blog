module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # Improve search results
    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mappings do
        indexes :title, analyzer: 'spanish'
        indexes :intro, analyzer: 'spanish'
      end
    end

    # Uncomment to enable elastic search API logs on rails server or rails console
    # __elasticsearch__.client = Elasticsearch::Client.new log: true
    # __elasticsearch__.client.transport.logger.formatter = proc { |s, d, p, m| "\e[32m#{m}\n\e[0m" }

    # Define strategies index nosql structure
    # Example:
    # {
    #   title: '...',
    #   intro: '...',
    #   servicetype: '...',
    #   tips: [ {tip_title: '...', content: '...'}, {tip_title: '...', content: '...'} ],
    #   authors: [ {name: ''}, {name: ''} ],
    #   categories: [ {category_name: '...', category_name: '...'} ]
    # }
    def as_indexed_json(options={})
      self.as_json(
        only: [:id, :title, :intro, :date, :servicetype],
        include: {
          tips: { only: [:id, :tip_title, :content] },
          authors: { only: [:id, :name] },
          categories: { only: [:id, :category_name] }
        }
      )
    end

    # Customize elasticseach behaviour
    # * highligh strategy title and content
    # * show results by descending date
    # * show all strategies if no search keyword is provided
    def self.search(query, options={})
      @search_definition = {
        query: {},

        # highlight strategy title and intro
        highlight: {
          pre_tags: ['<em class="search-highlight">'],
          post_tags: ['</em>'],
          fields: {
            title:  { number_of_fragments: 0 },
            intro:  { fragment_size: 50 }
          }
        }
      }

      unless query.blank?
        # Define field ranking, title being the highest
        @search_definition[:query] = {
          match: {
            _all: {
              query: query,
              fuzziness: 'AUTO'
            }
          }
        }
        # @search_definition[:query] = {
        #   multi_match: {
        #     query: query,
        #     fields: ['title^10', 'intro^2', 'servicetype']
        #   }
        # }
      else
        # Get all strategies by date if no search keyword (query) is provided
        @search_definition[:query] = { match_all: {} }
        @search_definition[:sort]  = { date: 'desc' }
      end

      __elasticsearch__.search(@search_definition)
    end

    after_touch() { __elasticsearch__.index_document }
  end

end
