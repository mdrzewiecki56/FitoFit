FactoryBot.define do
  factory :walk do
    start_address { "Plac Europejski 2, Warszawa, Polska" }
    end_address { "Poznańska 7, Warszawa, Polska" }
    start_lat { 52.23261995 }
    start_lng { 20.983807015690637 }
    end_lat { 52.2239858 }
    end_lng { 21.0123297 }
    distance { 2.17 }
  end
end
