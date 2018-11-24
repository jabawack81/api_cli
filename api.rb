# frozen_string_literal: true

require_relative "lib/user"
require_relative "lib/connection"

# main module of the application
module Api
  def self.most_sold
    purchases = Connection.get("purchases")
    purchases.group_by { |purchase| purchase["item"] }.max { |a, b| a[1].length <=> b[1].length }.first
  end

  def self.most_loyal
    purchases = Connection.get("purchases")
    user_id = purchases.group_by { |purchase| purchase["user_id"] }.max { |a, b| a[1].length <=> b[1].length }.first
    User.find(user_id)
  end

  def self.total_spend(email)
    user = User.find_by_email(email)
    purchases = Connection.get("purchases")
    purchases.select { |purchase| purchase["user_id"] == user.id }.map { |purchase| purchase["spend"].to_f }.sum
  end
end
