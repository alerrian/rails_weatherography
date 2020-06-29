class MapController < ApplicationController
  def index
    @states = State.all
    
    if params[:state_id]
      @state = State.find_by(id: params[:state_id])
      @weather = @state.get_weather(@state.lat, @state.long)
    end
  end

  def update
    @temp = params[:temp]

    redirect_to root_path
    require 'pry'; binding.pry
  end
end
