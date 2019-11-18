class ElevatorsController < ApplicationController
  def show
    redirect_to root_path
  end

  def call_to_floor
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    if @shaft[:min_floor] <= (params[:floor].to_i + @shaft[:min_floor]) && (params[:floor].to_i + @shaft[:min_floor]) <= @shaft[:max_floor]
      Elevator.call_to_floor(params[:id], params[:floor])
    end
    redirect_to root_path
  end

  def step
    Elevator.step(params[:id])
    redirect_to root_path
  end
end
