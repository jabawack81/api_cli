# frozen_string_literal: true

require_relative "../lib/connection.rb"

require_relative "spec_helper"
require "rspec"

RSpec.describe "Connection" do
  it "gets all the purchases" do
    VCR.use_cassette("purchases") do
      expect(Connection.get("purchases").length).to eq(100)
    end
  end
  it "gets all the users" do
    VCR.use_cassette("users") do
      expect(Connection.get("users").length).to eq(20)
    end
  end
end
