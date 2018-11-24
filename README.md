# Api CLI

The scope of the app is to query two endpoints (users and purchases) and with with the data retrieved allow the user to know the most sold item, the most loyal user and the total spend of a specific user.

## Gem
1. [Faraday](https://rubygems.org/gems/faraday) HTTP/REST API client library.
2. [Rspec](https://rubygems.org/gems/rspec) BDD for Ruby
3. [Vcr](https://rubygems.org/gems/vcr) Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
4. [email_address](https://rubygems.org/gems/email_address) The EmailAddress Gem to work with and validate email addresses.

## Usage
install the dependency:
```bundle install```
then
```ruby app.rb most_sold``` to get the most sold item
```ruby app.rb total_spend [EMAIL]```to get the total spend of a user
```ruby app.rb most_loyal``` to get the email of the most loyal user (most purchases)

or require the file ```driftlock.rb``` in another ruby script to have access to the sam function in a programmatic way

```ruby app.rb most_sold```
```total_spend [EMAIL]```to get the total spend of a user
```most_loyal``` to get the email of the most loyal user (most purchases)

```Driftrock.most_sold``` will return a string with the name of the most sold item (in a real world application I would return the product object)
```Driftrock.total_spend([EMAIL])``` will return a float number with the total spent from the user
```Driftrock.most_loyal``` will return a user object of the userwith the most purchases

## Errors

### app.rb
the app will raise a this exception:
```Malformed command``` if a parameter is passed to commands that dont need it (most_sold, most_loyal)
```Missing argument``` if the email parameter is not  passed to the most_loyal command
```Unrecognized command``` if the command cannot be recognized
### lib/hash.rb
```Malfomed Hash``` if the monkey patched method top_element is used on an hash not composed of only array as values
### lib/purchase.rb
```Attribute not available``` if an unavailable attribute is passed to the all_by method
### lib/user.rb
```Malformed Email Address``` if the email address for the find_by_email function is invalid
```User not found``` if a user is not found in the methods find and find_by_email
