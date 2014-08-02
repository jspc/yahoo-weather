#-*- mode: ruby -*-

Gem::Specification.new do |s|
  s.name = "yahoo-weather"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ['shaper', "jspc"]
  s.date = "2014-08-02"
  s.description = "Fork of Yahoo Weather api gem"
  s.summary = "Yahoo Weather"
  s.email = "james@zero-internet.org.uk"

  s.files =  %w{README.rdoc lib/yahoo-weather/astronomy.rb  lib/yahoo-weather/client.rb lib/yahoo-weather/forecast.rb   lib/yahoo-weather/location.rb   lib/yahoo-weather/units.rb lib/yahoo-weather/atmosphere.rb lib/yahoo-weather/condition.rb  lib/yahoo-weather/image.rb lib/yahoo-weather/response.rb lib/yahoo-weather/wind.rb}

  s.add_dependency( 'fog', '=1.19.0' )
  s.add_dependency( 'unf',  '=0.1.3' )
end
