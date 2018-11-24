# frozen_string_literal: true

require_relative "../lib/hash.rb"
require_relative "spec_helper"
require "rspec"

RSpec.describe "Hash" do
  describe "#top_element" do
    describe "with arrays as values" do
      it "will return the key with the highest number of elements" do
        valid_hash = {
          key_1: [:value_1a],
          key_2: %i[value_2a value_2b],
          key_3: %i[value_3a value_3b value_3c]
        }
        expect(valid_hash.top_element).to eq(:key_3)
      end
    end
    describe "with somenthingelse as values" do
      it "will return the key with the highest number of elements" do
        invalid_hash = {
          key_1: [:value_1a],
          key_2: %i[value_2a value_2b],
          key_3: :value_3a
        }
        expect { invalid_hash.top_element }.to raise_error("Malfomed Hash")
      end
    end
  end
end
