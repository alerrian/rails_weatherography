require 'json'

class WeatherService
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def get_weather
    response = connection.get("/data/2.5/find")

    json = JSON.parse(response.body)
    hash_response = hash_weather(json['list'])
  end
  
  def hash_weather(json_response)
    json_response.inject({}) do |new_hash, city|
      new_hash[city['name']] = {}
      new_hash[city['name']][:lat] = city['coord']['lat']
      new_hash[city['name']][:long] = city['coord']['lon']
      new_hash[city['name']][:temp] = city['main']['temp']
      new_hash[city['name']][:name] = city['name']
      new_hash
    end
  end
  
  private
  
  def connection
    connection = Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      faraday.use Faraday::HttpCache, store: Rails.cache
      faraday.adapter Faraday.default_adapter

      faraday.params['appid'] = Rails.application.credentials.owm[:api_key]
      faraday.params['lat'] = @lat
      faraday.params['lon'] = @long
      faraday.params['cnt'] = 50
      faraday.params['units'] = 'imperial'
    end
  end
end
