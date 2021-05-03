require 'rails_helper'

RSpec.describe Walk, type: :model do
  describe 'build_from_addresses' do
    it 'builds walk basing on string-format addresses' do
      expect(
        Walk.build_from_addresses(
          "Plac Europejski 2, Warszawa, Polska",
          "Poznańska 7, Warszawa, Polska"
        ).as_json.except("id", "created_at", "updated_at")
      ).to(be_eql({
                    "start_address"=>"Plac Europejski 2, Warszawa, Polska",
                    "end_address"=>"Poznańska 7, Warszawa, Polska",
                    "start_lat"=>52.23261995,
                    "start_lng"=>20.983807015690637,
                    "end_lat"=>52.2239858,
                    "end_lng"=>21.0123297,
                    "distance"=>2.17
      }))
    end

    it 'builds same walks even if addresses have slightly different format' do
      address1 = Walk.build_from_addresses(
          "Plac Europejski 2, Warszawa, Polska",
          "Poznańska 7, Warszawa, Polska"
        )
      address2 = Walk.build_from_addresses(
        ",Plac Europejski 2 Warszawa",
        "Warszawa Poznańska 7"
      )
      expect([address1.start_lat, address1.start_lng]).to be_eql([address2.start_lat, address2.start_lng])
      expect([address1.end_lat, address1.end_lng]).to be_eql([address2.end_lat, address2.end_lng])
    end
  end

  describe 'calculate_distance' do
    it 'calculates distance correctly' do
      expect(Walk.calculate_distance("Plac Europejski 2, Warszawa, Polska",
                              "Poznańska 7, Warszawa, Polska")).to be_eql(2.17)
    end
    it 'returns 0 if cannot find a location' do
      expect(Walk.calculate_distance("Nieistniejaca lokalizacja 1231",
                                     "Miejska wieś Polska")).to be_eql(0)
    end

  end
end
