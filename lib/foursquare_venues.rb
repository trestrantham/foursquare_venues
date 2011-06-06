require "typhoeus"
require "json"
require "foursquare_venues/version"
require "foursquare_venues/base"
require "foursquare_venues/venues" # proxy for Venue
require "foursquare_venues/venue"
require "foursquare_venues/location"
require "foursquare_venues/category"
require "foursquare_venues/photo"

module FoursquareVenues
  class Error < StandardError ; end
  class InvalidAuth < FoursquareVenues::Error; end
  class ServiceUnavailable < FoursquareVenues::Error; end

  def self.verbose=(setting)
    @verbose = setting
  end

  def self.verbose?
    @verbose
  end

  def self.log(msg)
    return unless verbose?
    puts "[foursquare_venues] #{msg}"
  end

  ERRORS = {
    "invalid_auth" => "OAuth token was not provided or was invalid.",
    "param_error" => "A required parameter was missing or a parameter was malformed. This is also used if the resource ID in the path is incorrect.",
    "endpoint_error" => "The requested path does not exist.",
    "not_authorized" => "Although authentication succeeded, the acting user is not allowed to see this information due to privacy restrictions.",
    "rate_limit_exceeded" => "Rate limit for this hour exceeded.",
    "deprecated" => "Something about this request is using deprecated functionality, or the response format may be about to change.",
    "server_error" => "Server is currently experiencing issues. Check status.foursquare.com for udpates.",
    "other" => "Some other type of error occurred."
  }
end