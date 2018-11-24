# frozen_string_literal: true

# most_sold:            What is the name of the most sold item?
# total_spend [EMAIL]:  What is the total spend of the user with this email address [EMAIL]?
# most_loyal:           What is the email address of the most loyal user (most purchases)?

require_relative "api"

command = ARGV[0]
argument = ARGV[1]

case command
when "most_sold"
  raise "Malformed command" unless argument.nil?

  puts Api.most_sold
when "total_spend"
  raise "Missing argument" if argument.nil?

  puts Api.total_spend(argument)
when "most_loyal"
  raise "Malformed command" unless argument.nil?

  puts Api.most_loyal.email
else
  raise "Unrecognized command"
end
