# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "foursquare_venues/version"

Gem::Specification.new do |s|
  s.name        = "foursquare_venues"
  s.version     = FoursquareVenues::VERSION
  s.authors     = ["Tres Trantham"]
  s.email       = ["tres@trestrantham.com"]
  s.homepage    = "https://github.com/trestrantham/foursquare_venues"
  s.summary     = %q{A Foursquare Venues API Wrapper}
  s.description = %q{A Foursquare Venues API Wrapper}

  s.rubyforge_project = "foursquare_venues"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.licenses = ["MIT"]
end
