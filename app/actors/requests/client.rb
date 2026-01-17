# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module Requests
  # Client Actor to make requests to the EasyBroker API
  class Client < Actor
    URI_BASE = 'https://api.stagingeb.com/v1'
    API_KEY = ENV.fetch('EASYBROKER_API_KEY', 'l7u502p8v46ba3ppgvj5y2aad50lb9') # should be a secret from ENV

    input :endpoint_path, type: String, required: false, default: '/properties'
    output :json_response, type: Hash

    def call
      self.json_response = request
    end

    def request
      url = URI("#{URI_BASE}#{endpoint_path}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['X-Authorization'] = API_KEY
      JSON.parse(http.request(request).body)
    end
  end
end
