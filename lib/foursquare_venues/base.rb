module FoursquareVenues
  class Base
    API = "https://api.foursquare.com/v2/venues/"

    def initialize(*args)
      case args.size
      when 2
        @client_id, @client_secret = args
      else
        raise ArgumentError, "You need to pass a client_id and client_secret"
      end
    end

    def venues
      FoursquareVenues::VenueProxy.new(self)
    end

    def get(path, params={})
      params = camelize(params)
      FoursquareVenues.log("GET #{API + path}")
      FoursquareVenues.log("PARAMS: #{params.inspect}")
			params.merge!(:client_id => @client_id, :client_secret => @client_secret)
      response = JSON.parse(Typhoeus::Request.get(API + path, :params => params).body)
      FoursquareVenues.log(response.inspect)
      error(response) || response["response"]
    end

    private

    def camelize(params)
      params.inject({}) { |o, (k, v)|
        o[k.to_s.gsub(/(_[a-z])/) { |m| m[1..1].upcase }] = v
        o
      }
    end

    def error(response)
      case response["meta"]["errorType"]
      when nil
        # It's all good.
      when "deprecated"
        FoursquareVenues.log(FoursquareVenues::ERRORS[response['meta']['errorType']])
        nil
      else
        error_type = response['meta']['errorType']
        case error_type
        when "invalid_auth"
          raise FoursquareVenues::InvalidAuth.new(FoursquareVenues::ERRORS[error_type])
        when "server_error"
          raise FoursquareVenues::ServiceUnavailable.new(FoursquareVenues::ERRORS[error_type])
        else
          raise FoursquareVenues::Error.new(FoursquareVenues::ERRORS[error_type])
        end
      end
    end
  end
end