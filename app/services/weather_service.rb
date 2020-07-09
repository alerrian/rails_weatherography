require 'json'

class WeatherService
  def get_weather(lat, long)
    response = connection(lat, long).get("/data/2.5/find") do |faraday|
      faraday.params['lat'] = lat
      faraday.params['lon'] = long
      faraday.params['cnt'] = 50
      faraday.params['units'] = 'imperial'
    end

    
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
  
  def connection(lat, long)
    connection = Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      faraday.use Faraday::HttpCache, store: Rails.cache
      faraday.adapter Faraday.default_adapter

      faraday.params['appid'] = Figaro.env.owm_api
    end
  end
end
