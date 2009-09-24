# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Product.delete_all

euro = Currency.new(:name => 'Euro', :symbol => '€', :code => 'EUR', :format => '#{amount}€')

Product.create(:name => 'Mighty mouse',
               :description => 'Crappy mouse from Apple',
               :tags => ['apple', 'mouse', 'bad'],
               :price => Price.new(:amount => 49, :currency => euro))

Product.create(:name => 'iMac',
               :description => 'Nice intel computer from Apple',
               :tags => ['apple', 'intel', 'good'],
               :price => Price.new(:amount => 899, :currency => euro))

Product.create(:name => 'iPod touch',
               :description => 'Nice mp3 and video player with lots of applications',
               :tags => ['apple', 'mp3', 'video', 'big'],
               :price => Price.new(:amount => 199, :currency => euro))