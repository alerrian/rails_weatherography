class MapController < ApplicationController
  def index
    @states = State.all
    
    if params[:state_id]
      @state = State.find_by(id: params[:state_id])
    end
  end
  
  def weather
    if params[:state_id]
      @state = State.find_by(id: params[:state_id])
    end
    
    weather_service = WeatherService.new
    @weather = weather_service.get_weather(@state.lat, @state.long)

    render json: {data: @weather.to_json.html_safe}
  end
end
