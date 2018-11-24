# frozen_string_literal: true

require_relative "../api.rb"
require_relative "spec_helper"
require "rspec"

RSpec.describe "Api" do
  describe "#most_sold" do
    it "gets the most sold item" do
      VCR.use_cassette("purchases") do
        expect(Api.most_sold).to eq("Heavy Duty Concrete Watch")
      end
    end
  end
  describe "#most_loyal" do
    it "gets the most loyal user" do
      VCR.use_cassette("users_purchases") do
        expect(Api.most_loyal.email).to eq("travis_kshlerin@wunsch.net")
      end
    end
  end
  describe "#total_spend" do
    it "gets the total_spend for a user" do
      VCR.use_cassette("users_purchases") do
        expect(Api.total_spend("travis_kshlerin@wunsch.net")).to eq(336.76)
      end
    end
    it "will raise an exception with a invalid email" do
      expect { Api.total_spend("invalidemail") }.to raise_exception("Malformed Email Address")
    end
    it "will raise an exception with a email not present" do
      VCR.use_cassette("users") do
        expect { Api.total_spend("not@inlist.net") }.to raise_exception("User not found")
      end
    end
  end
end
