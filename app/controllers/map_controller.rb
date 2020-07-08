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
    
    weather_service = WeatherService.new(@state.lat, @state.long)
    @weather = weather_service.get_weather

    render json: {data: @weather.to_json.html_safe}
  end
end
