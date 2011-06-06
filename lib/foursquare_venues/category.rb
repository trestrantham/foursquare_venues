module FoursquareVenues
  class Category
    
    def initialize(json)
      @json = json
    end
    
    def name
      @json["name"]
    end
    
    def plural_name
      @json["pluralName"]
    end
    
    def icon
      @json["icon"]
    end
    
    # array
    def parents
      @json["parents"]
    end
    
    def primary?
      @json["primary"] == true
    end
    
  end
end