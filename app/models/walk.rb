class Walk < ApplicationRecord

  def self.build_from_addresses(start_address, end_address)
    start_geo = Geocoder.search(start_address).first
    end_geo = Geocoder.search(end_address).first
    start_coords = start_geo.coordinates
    end_coords = end_geo.coordinates
    Walk.create!(
      start_address: GeocodingService.format_address(start_geo),
      end_address: GeocodingService.format_address(end_geo),
      start_lat: start_coords.first,
      start_lng: start_coords.second,
      end_lat: end_coords.first,
      end_lng: end_coords.second,
      distance: Geocoder::Calculations.distance_between(start_coords, end_coords).round(2)
    )
  end

  def self.calculate_distance(address_from, address_to)
    from = Geocoder.search(address_from).first&.coordinates
    to = Geocoder.search(address_to).first&.coordinates
    if from && to
      @distance = Geocoder::Calculations.distance_between(from, to).round(2)
    else
      @distance = 0
    end
  end

end
