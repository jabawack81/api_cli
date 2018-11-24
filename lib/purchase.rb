# frozen_string_literal: true

require_relative "connection"

class Purchase
  ATTRIBUTES = %i[user_id item spend].freeze

  attr_reader(*ATTRIBUTES)

  def initialize(json)
    @item = json["item"]
    @spend = json["spend"].to_f
    @user_id = json["user_id"]
  end

  def self.all
    Connection.get("purchases").map { |purchase| new(purchase) }
  end

  def self.all_by(attribute)
    raise "Attribute not available" unless ATTRIBUTES.include? attribute

    all.group_by(&attribute)
  end

  def self.find_by_user(user)
    all.select { |purchase| purchase.user_id == user.id }
  end
end
