class MainController < ApplicationController
  def index
    @shaft = { floors: 5, max_floor: 3, min_floor: -1, floor_names: ['SB', 'B', 'L', '2', '3'] }
    @elevators = Elevator.status(0)
  end
end
