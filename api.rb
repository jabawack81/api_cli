# frozen_string_literal: true

require_relative "lib/connection"

# main module of the application
module Api
  def self.most_sold
    purchases = Connection.get("purchases")
    purchases.group_by { |purchase| purchase["item"] }.max { |a, b| a[1].length <=> b[1].length }.first
  end

  def self.most_loyal
    users = Connection.get("users")
    purchases = Connection.get("purchases")
    user_id = purchases.group_by { |purchase| purchase["user_id"] }.max { |a, b| a[1].length <=> b[1].length }.first
    users.select { |user| user["id"] == user_id }.first["email"]
  end

  def self.total_spend(email)
    users = Connection.get("users")
    purchases = Connection.get("purchases")
    user_id = users.select { |user| user["email"] == email }.first["id"]
    purchases.select { |purchase| purchase["user_id"] == user_id }.map { |purchase| purchase["spend"].to_f }.sum
  end
end
