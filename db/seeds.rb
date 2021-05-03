# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

walk1 = Walk.build_from_addresses("Plac Europejski 2, Warszawa, Polska", "Poznańska 7, Warszawa, Polska")
walk2 = Walk.build_from_addresses("Plac Europejski 2, Warszawa, Polska", "Poznańska 7, Warszawa, Polska")
walk3 = Walk.build_from_addresses("Plac Europejski 2, Warszawa, Polska", "Poznańska 7, Warszawa, Polska")
walk4 = Walk.build_from_addresses("Nowy Świat , Warszawa, Polska", "Świętokrzyska , Warszawa, Polska")
walk5 = Walk.build_from_addresses("Nowy Świat , Warszawa, Polska", "Świętokrzyska , Warszawa, Polska")

walk1.update(created_at: DateTime.new(2021,5,1))
walk2.update(created_at: DateTime.new(2021,5,1))
walk3.update(created_at: DateTime.new(2021,5,2))
walk4.update(created_at: DateTime.new(2021,4,30))
walk5.update(created_at: DateTime.new(2021,4,29))