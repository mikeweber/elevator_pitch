class ElevatorsController < ApplicationController
  def show
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    @elevator = Elevator.status(params[:id])
    render 'main/index'
  end

  def call_to_floor
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    if @shaft[:min_floor] <= (params[:floor].to_i + @shaft[:min_floor]) && (params[:floor].to_i + @shaft[:min_floor]) <= @shaft[:max_floor]
      Elevator.call_to_floor(params[:id], params[:floor])
    end
    @elevator = Elevator.status(params[:id])
    render 'main/index'
  end

  def step
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    @elevator = Elevator.step(params[:id])
    render 'main/index'
  end
end
