# frozen_string_literal: true

module Orchestators
  # Orchestator Actor to list locations
  class ListLocations < Actor
    input :endpoint_path, type: String, default: '/properties'

    output :locations, type: Array

    play Requests::Client
    play Locations::List
  end
end
