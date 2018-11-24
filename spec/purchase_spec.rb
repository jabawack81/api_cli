# frozen_string_literal: true

require_relative "../lib/purchase.rb"
require_relative "../lib/user.rb"
require_relative "spec_helper"
require "rspec"

RSpec.describe "Purchase" do
  describe "#new" do
    subject do
      Purchase.new(
        "user_id" => "user_id",
        "item" => "item",
        "spend" => "0.0"
      )
    end
    it "initialize a new purchase object" do
      expect(subject.user_id).to eq("user_id")
      expect(subject.item).to eq("item")
      expect(subject.spend).to eq(0.0)
    end
  end
  describe "#all" do
    subject do
      VCR.use_cassette("purchases") do
        Purchase.all
      end
    end
    describe "gets all the purchase from the api" do
      it "will return all the purchases" do
        expect(subject.length).to eq(100)
      end
      it "will return an Array" do
        expect(subject.class).to eq(Array)
      end
      it "will return an array of Purchases" do
        expect(subject.first.class).to eq(Purchase)
      end
    end
  end
  describe "#all_by" do
    describe "with a valid attribute" do
      it "will return an hash" do
        expect { Purchase.all_by(:invalid_attribute) }.to raise_error("Attribute not available")
      end
    end
    describe "with a valid attribute" do
      subject do
        VCR.use_cassette("purchases") do
          Purchase.all_by(:user_id)
        end
      end
      describe "gets all the purchase grouped by a specific attribute" do
        it "will return an hash" do
          expect(subject.class).to eq(Hash)
        end
        it "will cointain arrays" do
          expect(subject.first.class).to eq(Array)
        end
        it "will group element with the key in the attribute" do
          random_key = subject.keys.sample
          expect(subject[random_key].first.user_id).to eq(random_key)
        end
      end
    end
  end
  describe "#find_by_user" do
    let(:user) do
      User.new(
        "id" => "FFWN-1CKR-X4WU-Q44M",
        "first_name" => "Kelley",
        "last_name" => "Paucek",
        "phone" => "657.511.1172",
        "email" => "kelley_paucek@jakubowski.biz"
      )
    end
    subject do
      VCR.use_cassette("users_purchases") do
        Purchase.find_by_user(user)
      end
    end
    describe "gets all the purchases for a specific user" do
      it "will return a array" do
        expect(subject.class).to eq(Array)
      end
      it "will return a array of Purchases" do
        expect(subject.first.class).to eq(Purchase)
      end
      it "will return all purchase for the provided user" do
        expect(subject.map(&:user_id).uniq).to eq([user.id])
      end
    end
  end
end
