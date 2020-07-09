class MapController < ApplicationController
  def index
    @states = State.all
    
    if params[:state_id]
      @state = State.find_by(id: params[:state_id])
    end
  end
  
  def weather
    current_state = State.find_by(id: params[:state_id])

    weather_service = WeatherService.new(current_state.lat, current_state.long)
    weather = weather_service.get_weather

    render json: {data: weather.to_json.html_safe}
  end
end
