# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

store = Store.find(2)

store.customers.create!(
  name: "Padmanaban Muthukumarasamy",
  email: "padmanabanmuthukumarasamy@gmail.com"
)

store.customers.create!(name: "Albert", email: "albert.selvaraj@freshworks.com")
store.customers.create!(name: "Chitra", email: "chitra.muthukumaran@freshworks.com")
