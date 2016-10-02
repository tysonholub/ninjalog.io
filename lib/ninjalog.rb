require "ninjalog/version"
require "logger"

module NinjaLog
  class NinjaLogger < Logger
    def initialize(email, id, secret)
      super(NinjaLogDev.new(email, id, secret))
    end
  end

  class NinjaLogDev
    def initialize(email, id, secret)
      @headers = { 'Accept' => 'application/json' }
      response = Unirest.post 'http://www.ninjalog.io/api/v1/auth/token',
        headers: @headers,
        parameters: {
          :email => email,
          :client_id => id
        }
      decoded = decode(response.body, secret)
      @headers.update({
        'Authorization' => "Bearer #{decoded['auth_token']}"
      })
    end

    def write(message)
      Unirest.post 'http://www.ninjalog.io/api/v1/log',
        headers: @headers,
        parameters: {
          :message => message
        } { |response|
          #async request block
        }
    end

    def close
      #LoggerDevice requires implementing write/close methods
    end

    def decode(token, secret)
      decoded = JWT.decode(token, secret)
      return decoded[0] unless decoded[0].nil?
      raise JWT::DecodeError, 'Attempt to decode invalid token'
    end
  end
end
