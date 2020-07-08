require 'json'

class WeatherService
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def get_weather
    response = Faraday.get("http://api.openweathermap.org/data/2.5/find?lat=#{@lat}&lon=#{@long}&cnt=50&appid=#{ENV['OWM_API']}&units=imperial")
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
end
