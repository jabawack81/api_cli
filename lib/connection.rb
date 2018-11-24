# frozen_string_literal: true

require "faraday"
require "json"

# module to communicate with the API endpoint
module Connection
  BASE_URI = "https://driftrock-dev-test.herokuapp.com"

  def self.get(resource)
    response = Faraday.get("#{BASE_URI}/#{resource}")
    JSON.parse(response.body)["data"]
  end
end
