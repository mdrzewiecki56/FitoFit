require 'rails_helper'

RSpec.describe "Walks", type: :request do

  describe 'create' do
    it 'creates a new walk' do
      walk = build(:walk)
      post '/walks', params: {walk: {start_address:"Plac Europejski 2, Warszawa, Polska", end_address:"Poznańska 7, Warszawa, Polska" }}
      expect(Walk.last.start_address).to be_eql(walk.start_address)
    end
  end

  describe 'calculate_distance' do
    it 'returns a distance between two addresses' do
      get '/walks/calculate_distance', params: {start_address:"Plac Europejski 2, Warszawa, Polska", end_address:"Poznańska 7, Warszawa, Polska" }
      expect(response.body).to be_eql("{\"distance\":2.17}")
    end
  end

  describe 'autocomplete' do
    it 'returns locations for the text query' do
      get '/walks/autocomplete', params: {query:"Plac Europejski 2"}
      expect(response.body).to(
        be_eql("{\"locations\":[\"Plac Europejski 2, Warszawa, Polska\",\"Plac Europejski , Warszawa, Polska\"]}"))
    end
  end
end
