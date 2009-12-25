# Describes the weather conditions for a particular requested location.
class YahooWeather::Response
  # a YahooWeather::Astronomy object detailing the sunrise and sunset
  # information for the requested location.
  attr_reader :astronomy

  # a YahooWeather::Location object detailing the precise geographical names
  # to which the requested location was mapped.
  attr_reader :location

  # a YahooWeather::Units object detailing the units corresponding to the
  # information detailed in the response.
  attr_reader :units

  # a YahooWeather::Wind object detailing the wind information at the
  # requested location.
  attr_reader :wind

  # a YahooWeather::Atmosphere object detailing the atmosphere information
  # of the requested location.
  attr_reader :atmosphere

  # a YahooWeather::Condition object detailing the current conditions of the
  # requested location.
  attr_reader :condition

  # a list of YahooWeather::Forecast objects detailing the high-level
  # forecasted weather conditions for upcoming days.
  attr_reader :forecasts

  # the raw HTML generated by the Yahoo! Weather service summarizing current
  # weather conditions for the requested location.
  attr_reader :description

  # a YahooWeather::Image record describing an image icon
  # representing the current weather.
  attr_reader :image

  # the latitude of the location for which weather is detailed.
  attr_reader :latitude

  # the longitude of the location for which weather is detailed.
  attr_reader :longitude

  # a link to the Yahoo! Weather page with full detailed information on the
  # requested location's current weather conditions.
  attr_reader :page_url

  # the location string initially requested of the service.
  attr_reader :request_location

  # the url with which the Yahoo! Weather service was accessed to build the response.
  attr_reader :request_url

  # the prose descriptive title of the weather information.
  attr_reader :title

  def initialize (request_location, request_url, doc)
    # save off the request params
    @request_location = request_location
    @request_url = request_url

    # parse the nokogiri xml document to gather response data
    root = doc.xpath('/rss/channel').first

    @astronomy = YahooWeather::Astronomy.new(root.xpath('yweather:astronomy').first)
    @location = YahooWeather::Location.new(root.xpath('yweather:location').first)
    @units = YahooWeather::Units.new(root.xpath('yweather:units').first)
    @wind = YahooWeather::Wind.new(root.xpath('yweather:wind').first)
    @atmosphere = YahooWeather::Atmosphere.new(root.xpath('yweather:atmosphere').first)
    @image = YahooWeather::Image.new(root.xpath('image').first)

    item = root.xpath('item').first
    @condition = YahooWeather::Condition.
      new(item.xpath('yweather:condition').first)
    @forecasts = []
    item.xpath('yweather:forecast').each { |forecast| 
      @forecasts << YahooWeather::Forecast.new(forecast) }
    @latitude = item.xpath('geo:lat').first.content.to_f
    @longitude = item.xpath('geo:long').first.content.to_f
    @page_url = item.xpath('link').first.content
    @title = item.xpath('title').first.content
    @description = item.xpath('description').first.content
  end
end
