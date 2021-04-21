class WalksController < ApplicationController
  def index

  end

  def show

  end

  def update

  end

  def destroy

  end

  private
  def walk_params
    params.require(:walk).permit(:start_lat, :start_lng, :end_lat, :end_lng)
  end
end
