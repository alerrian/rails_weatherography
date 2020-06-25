class State < ApplicationRecord
  validates_presence_of :name,
                        :lat,
                        :long,
                        :zoom

  validates_uniqueness_of :name

  def get_weather(lat, long)
    Faraday.get("http://api.openweathermap.org/data/2.5/find?lat=#{lat}&lon=#{long}&cnt=10&appid=#{ENV['OWM_API']}")
  end
end
