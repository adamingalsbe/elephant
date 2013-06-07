# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class CreateUsers < ActiveRecord::Migration
create_table :users do |t|
  t.string :first_name
  t.string :last_name
  t.string :email_address
  t.timestamps
end
end

data = [{first_name: "Carl", last_name: "Carlson", email_address: "carl@aol.com"}, {first_name: "Hank", last_name: "Hankerton", email_address: "hank@aol.com"}]

data.each do |user_info|
  m = User.new
  m.first_name = user_info[:first_name]
  m.last_name = user_info[:last_name]
  m.email_address = user_info[:email_address]
  m.save(:validate => false)
end
