# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless Spina::Account.exists?
  puts 'Seeding Spina account'
  account = Spina::Account.first_or_create
  account.update(name: 'My Website', theme: 'default')

  Spina::THEMES.clear
  Dir[Rails.root.join("config", "initializers", "themes", "*.rb")].each { |file| load file }

  account.save

  puts 'Creating admin user'
  unless Spina::User.exists?
    Spina::User.create(
      name: 'admin',
      email: 'admin@spina.com',
      password: 'password',
      admin: true
    )
  end

  puts 'Spina seeding was successful'
end