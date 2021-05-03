class WalksController < ApplicationController
  def create
    @walk = Walk.build_from_addresses(
      walk_params[:start_address],
      walk_params[:end_address]
    )
    render 'walks/show', status: :ok
  end

  def calculate_distance
    @distance = Walk.calculate_distance(params[:start_address], params[:end_address])
    render 'walks/calculate_distance', status: :ok
  end

  def autocomplete
    user_loc = params[:user_location]&.none?(&:nil?) ? params[:user_location] : request.location.ip
    # This would be more efficient If I implemented whole user sessions functionality
    # Fetching user location with every request is not the best option
    # Implemented it for testing purposes so it's easier to check distance correctness for added walks
    @locations = GeocodingService.new(user_loc).search_in_user_country(params[:query]).uniq.first(10)
    render 'walks/autocomplete', status: :ok
  end

  private
  def walk_params
    params.require(:walk).permit(:id,:start_address, :end_address)
  end
end
