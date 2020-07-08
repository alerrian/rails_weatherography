class MapController < ApplicationController
  def index
    @states = State.all
    
    if params[:state_id]
      @state = State.find_by(id: params[:state_id])
    end
  end
  
  def weather
    @weather = @state.get_weather(@state.lat, @state.long)
  end
end
