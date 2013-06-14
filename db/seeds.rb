# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class CreateUsers < ActiveRecord::Migration
end

data = [{first_name: "Carl", last_name: "Carlson", email_address: "carl@aol.com"}, {first_name: "Hank", last_name: "Hankerton", email_address: "hank@aol.com"}]

data.each do |user_info|
  m = User.new
  m.first_name = user_info[:first_name]
  m.last_name = user_info[:last_name]
  m.email_address = user_info[:email_address]
  m.save(:validate => false)
end

data = [{name: "Citi Bank", notes: "Notes for bank", user_id: 1}, {name: "JP Morgan", notes: "Notes for bank", user_id: 1}]

data.each do |bank_info|
  m = Bank.new
  m.name = bank_info[:name]
  m.notes = bank_info[:notes]
  m.user_id = bank_info[:user_id]
  m.save(:validate => false)
end
