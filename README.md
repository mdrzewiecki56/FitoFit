# FitoFit API

## Ruby version
Ruby 3.0.0

## Configuration
- Api uses postgresql database, so you need one to proceed
- Edit <code>database.yml</code> with config that suits your needs.
- <code>bundle install</code>
- <code>rails s</code>

### Comments
There's only one model - Walk, used to store walks' data,
there are also two services:
- GeocodingService which stores methods which are useful in terms of geocoding locations
- StatisticsServices::WalkSummary - service for generating walk statistics

CORS accepts all origins. 

I hope that this architecture meets your requirements I was wondering 
if I shouldn't split walks into more models (like additonal model, 
only for locations, to collect additional data about places. 
Then I could use <code>geocoded_by:</code> and other Geocoder's tricks). 
I've decided to implement only the basic functionalities that were specified by you.

I've written some tests, not 100% coverage, but wanted to show my testing skills. (looking forward on feedback on it)

I set up some really basic seeds, not much but they allow to look into statistics (April, May)