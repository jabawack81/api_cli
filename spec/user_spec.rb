# frozen_string_literal: true

require_relative "../lib/user.rb"
require_relative "spec_helper"
require "rspec"

RSpec.describe "User" do
  describe "#new" do
    subject do
      User.new(
        "id" => "FFWN-1CKR-X4WU-Q44M",
        "first_name" => "Kelley",
        "last_name" => "Paucek",
        "phone" => "657.511.1172",
        "email" => "kelley_paucek@jakubowski.biz"
      )
    end
    it "initialize a new purchase object" do
      expect(subject.id).to eq("FFWN-1CKR-X4WU-Q44M")
      expect(subject.first_name).to eq("Kelley")
      expect(subject.last_name).to eq("Paucek")
      expect(subject.phone).to eq("657.511.1172")
      expect(subject.email).to eq("kelley_paucek@jakubowski.biz")
    end
  end
  describe "#all" do
    subject do
      VCR.use_cassette("users") do
        User.all
      end
    end
    describe "gets all the purchase from the api" do
      it "will return all the purchases" do
        expect(subject.length).to eq(20)
      end
      it "will return an Array" do
        expect(subject.class).to eq(Array)
      end
      it "will return an array of Purchase" do
        expect(subject.first.class).to eq(User)
      end
    end
  end
  describe "#find" do
    let(:id) { "KZHR-1H35-2IH8-JXYN" }
    subject do
      VCR.use_cassette("users") do
        User.find(id)
      end
    end
    describe "return the user with the specified id" do
      it "will return a User" do
        expect(subject.class).to eq(User)
      end
      it "will return a user with the specified id" do
        expect(subject.id).to eq(id)
      end
    end
  end
  describe "#find_by_email" do
    let(:email) { "schimmel_quincy@ernser.io" }
    subject do
      VCR.use_cassette("users") do
        User.find_by_email(email)
      end
    end
    describe "return the user with the specified email" do
      it "will return a User" do
        expect(subject.class).to eq(User)
      end
      it "will return a user with the specified email" do
        expect(subject.email).to eq(email)
      end
    end
  end
end
