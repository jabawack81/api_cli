# frozen_string_literal: true

# monkeypatch to add a function to the hash class
# that returns the key with the most element in the
# associate array.
class Hash
  def top_element
    raise("Malfomed Hash") unless values.map(&:class).uniq == [Array]

    max { |a, b| a[1].length <=> b[1].length }.first
  end
end
