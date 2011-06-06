module FoursquareVenues
  class Venues
    def initialize(*args)
      case args.size
      when 2
        @client_id, @client_secret = args
				@foursquare = FoursquareVenues::Base.new(@client_id, @client_secret)
      else
        raise ArgumentError, "You need to pass a client_id and client_secret"
      end
    end

    def find(id)
      FoursquareVenues::Venue.new(@foursquare, @foursquare.get("#{id}")["venue"])
    end

    def search(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]
      response = @foursquare.get('search', options)["groups"].inject({}) do |venues, group|
        venues[group["type"]] ||= []
        venues[group["type"]] += group["items"].map do |json|
          FoursquareVenues::Venue.new(@foursquare, json)
        end
        venues
      end
    end

    def trending(options={})
      search_group("trending", options)
    end

    def favorites(options={})
      search_group("favorites", options)
    end

    def nearby(options={})
      search_group("nearby", options)
    end

    private

    def search_group(name, options)
      raise ArgumentError, "You must include :ll" unless options[:ll]
      response = @foursquare.get('search', options)["groups"].detect { |group| group["type"] == name }
      response ? response["items"].map do |json|
        FoursquareVenues::Venue.new(@foursquare, json)
      end : []
    end
  end
end