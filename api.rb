# frozen_string_literal: true

require "faraday"
require "json"

# main module of the application
module Api
  def self.most_sold
    response = Faraday.get("https://driftrock-dev-test.herokuapp.com/purchases")
    purchases = JSON.parse(response.body)["data"]
    purchases.group_by { |purchase| purchase["item"] }.max { |a, b| a[1].length <=> b[1].length }.first
  end

  def self.most_loyal
    users_response = Faraday.get("https://driftrock-dev-test.herokuapp.com/users")
    purchases_response = Faraday.get("https://driftrock-dev-test.herokuapp.com/purchases")
    users = JSON.parse(users_response.body)["data"]
    purchases = JSON.parse(purchases_response.body)["data"]
    user_id = purchases.group_by { |purchase| purchase["user_id"] }.max { |a, b| a[1].length <=> b[1].length }.first
    users.select { |user| user["id"] == user_id }.first["email"]
  end

  def self.total_spend(email)
    users_response = Faraday.get("https://driftrock-dev-test.herokuapp.com/users")
    purchases_response = Faraday.get("https://driftrock-dev-test.herokuapp.com/purchases")
    users = JSON.parse(users_response.body)["data"]
    purchases = JSON.parse(purchases_response.body)["data"]
    user_id = users.select { |user| user["email"] == email }.first["id"]
    purchases.select { |purchase| purchase["user_id"] == user_id }.map { |purchase| purchase["spend"].to_f }.sum
  end
end
