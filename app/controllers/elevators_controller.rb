class ElevatorsController < ApplicationController
  def show
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def call_to_floor
    @shaft = { floors: 5, max_floor: 3, min_floor: -1 }
    if @shaft[:min_floor] <= (params[:floor].to_i + @shaft[:min_floor]) && (params[:floor].to_i + @shaft[:min_floor]) <= @shaft[:max_floor]
      Elevator.call_to_floor(params[:floor])
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def step
    Elevator.step
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
