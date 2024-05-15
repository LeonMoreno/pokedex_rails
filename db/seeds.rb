# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

puts "Seed process Init"

puts '-------------------------------'

csv_text = File.read(Rails.root.join('db', 'csv', 'pokemons.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
num = 0
csv.each do |row|

  poke = Pokemon.find_or_initialize_by(name: row['Name'])

  if poke.new_record?
    poke.num = row['#']
    poke.name = row['Name']
    poke.type_1 = row['Type 1']
    poke.type_2 = row['Type 2']
    poke.total = row['Total']
    poke.hp = row['HP']
    poke.attack = row['Attack']
    poke.defense = row['Defense']
    poke.sp_atk = row['Sp. Atk']
    poke.sp_def = row['Sp. Def']
    poke.speed = row['Speed']
    poke.generation = row['Generation']
    poke.legendary = row['Legendary']
    poke.save
    puts "Pokemon: #{row['Name']} created with success!"
    num = num + 1
  else
    puts "Pokemon: #{poke.name} -- already exists"
  end
end

puts "\n ------------------------------- \n"
puts "TOtal pokemons Create = #{num}"

puts "Seed process end"