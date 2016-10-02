# Ninjalog.rb

ninjalog is a secure, open source web service for centralized logging. Checkout [ninjalog.io](http://www.ninjalog.io) to create a free account. This gem wraps the Ruby Logger sending your log data directly to the cloud instead of to disk.

ninjalog.io uses [jwt](http://jwt.io) authentication with rails 5 websockets for live log tailing. Data is persisted via redis and can be downloaded to disk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ninjalog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ninjalog

## Usage

Create a new NinjaLog::NinjaLogger providing your ninjalog.io email account and generated client_id and client_secret, then use the logger as you would the Ruby Logger class.

Set your Rails.application logger in any environment file:

```ruby
Rails.application.configure do
  config.logger = NinjaLog::NinjaLogger.new(email, client_id, client_secret)
end
```

Or use ninjalog outside a Rails application:

```ruby
require 'ninjalog'

logger = NinjaLog::NinjaLogger(email, client_id, client_secret)
logger.info('Logging to the cloud. weeee')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tysonholub/ninjalog.rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
