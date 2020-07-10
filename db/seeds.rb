# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@arizona = State.create!(name: 'Arizona', lat: 34.4747, long: -111.7892, zoom: 7)
@colorado = State.create!(name: 'Colorado', lat: 39.3026, long: -105.343061, zoom: 7)
@connecticut = State.create!(name: 'Connecticut', lat: 41.5000, long: -72.7000, zoom: 9)
@washington = State.create!(name: 'Washington', lat: 47.2958, long: -120.3417, zoom: 7)
@wyoming = State.create!(name: 'Wyoming', lat: 43.1263, long: -107.6203, zoom: 7)