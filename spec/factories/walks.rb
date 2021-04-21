FactoryBot.define do
  factory :walk do
    start_address { "MyString" }
    end_address { "MyString" }
    start_lat { 1.5 }
    start_lng { 1.5 }
    end_lat { 1.5 }
    end_lng { 1.5 }
    distance { 1.5 }
  end
end
