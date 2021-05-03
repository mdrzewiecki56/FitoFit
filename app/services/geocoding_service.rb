class GeocodingService
  def initialize(user_loc)
    @user_country = initialize_user_country(user_loc)
  end

  def search_in_user_country(query)
    results = Geocoder.search(query, params: @user_country ? {countrycodes: @user_country} : {})
    results.map {|r| GeocodingService.format_address(r)}
  end

  def self.format_address(geolocation)
    "#{geolocation.street} #{geolocation.house_number}, #{geolocation.city}, #{geolocation.country}"
  end

  private

  def initialize_user_country(user_loc)
    ip_regex = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
    Geocoder.search(user_loc)&.first&.country_code if (user_loc.is_a? Array || user_loc.match(ip_regex))
  end
end