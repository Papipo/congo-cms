# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Product.delete_all

euro = Currency.new(:name => 'Euro', :symbol => '€', :code => 'EUR', :format => '#{amount}€')
p = Product.create(:name => 'My product',
                   :description => 'Loren Ipsum',
                   :tags => ['mongo', 'ruby', 'awesome'],
                   :price => Price.new(:amount => 15, :currency => euro))