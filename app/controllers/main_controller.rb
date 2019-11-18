class MainController < ApplicationController
  def index
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    @elevator = Elevator.status(params[:id])
  end
end
