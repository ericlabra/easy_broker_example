# frozen_string_literal: true

module Locations
  # Actor to list locations
  class List < Actor
    input :json_response, type: Hash

    output :locations, type: Array

    def call
      self.locations = json_response['content'].map { |location| location['title'] }

      # log locations
      locations.each_with_index { |location, index| puts "#{index + 1}. #{location}" }
    end
  end
end
