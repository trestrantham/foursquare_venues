# foursquare_venues

A Foursquare Venues API wrapper based off of [Quimby](https://github.com/groupme/quimby).

foursquare_venues removes all dependency on user authentication from Quimby and focuses solely on the Venues API.

Documentation good bits extracted from Quimby:

## Installation

Install it as a gem (in your `Gemfile`) and its dependencies:

    gem "json"
    gem "typhoeus"
    gem "foursquare_venues"
    
## Setup

First, you need to [register your application](https://foursquare.com/oauth).

Then, get a foursquare_venues with your `client_id` and `client_secret`:

    foursquare_venues = FoursquareVenues::Venues.new("CLIENT_ID", "CLIENT_SECRET")
    
### Usage

To find a venue directly:

    foursquare_venues.find("VENUE_ID")

You can also search venues:

    foursquare_venues.search(:ll => "40.7236307,-73.9999479") # Returns all resulting groups
    foursquare_venues.nearby(:ll => "40.7236307,-73.9999479") # Returns only nearby venues
    foursquare_venues.trending(:ll => "40.7236307,-73.9999479") # Returns only trending venues
    foursquare_venues.favorites(:ll => "40.7236307,-73.9999479") # Returns only favorite venues

The `:ll` option is required for venue searches. You can also feel free to pass any of the other
available Foursquare API options, as specified in the docs.

### Logging

If you want to see what's going on up in there, you can set `Foursquare.verbose` to `true`

    Foursquare.verbose = true

Right now it'll log to `STDOUT`. If you want to use your own logger, you can do something like this:

    Foursquare.verbose = true
    def Foursquare.log(message)
      Rails.logger.info("[foursquare] #{message}")
    end