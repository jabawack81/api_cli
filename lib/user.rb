# frozen_string_literal: true

require_relative "connection"
require "email_address"

# user class
class User
  attr_reader :id,
              :first_name,
              :last_name,
              :phone,
              :email

  def initialize(json)
    @id = json["id"]
    @first_name = json["first_name"]
    @last_name = json["last_name"]
    @phone = json["phone"]
    @email = json["email"]
  end

  def self.all
    users = Connection.get("users")
    users.map { |user| new(user) }
  end

  def self.find(id)
    all.select { |user| user.id == id }.first || raise("User not found")
  end

  def self.find_by_email(email)
    raise "Malformed Email Address" unless EmailAddress.valid?(email, host_validation: :syntax)

    all.select { |user| user.email == email }.first || raise("User not found")
  end
end
