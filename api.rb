# frozen_string_literal: true

require_relative "lib/connection"
require_relative "lib/purchase"
require_relative "lib/user"

# main module of the application
module Api
  def self.most_sold
    Purchase.all_by(:item).max { |a, b| a[1].length <=> b[1].length }.first
  end

  def self.most_loyal
    user_id = Purchase.all_by(:user_id).max { |a, b| a[1].length <=> b[1].length }.first
    User.find(user_id)
  end

  def self.total_spend(email)
    user = User.find_by_email(email)

    Purchase.find_by_user(user).map(&:spend).sum
  end
end
