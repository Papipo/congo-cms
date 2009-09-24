# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

DynamicType.delete_all

DynamicType.create(:_id  => 'Currency', :embedded => true,
                 :keys => [
                   {:name => 'name'},
                   {:name => 'code'},
                   {:name => 'symbol'}
                 ])

DynamicType.create(:id  => 'Price', :embedded => true,
                 :keys => [
                   {:name => 'amount',   :type => 'Float' },
                   {:name => 'currency', :type => 'Currency' }
                 ])

DynamicType.create(:id => 'Product', :embedded => false,
                 :keys => [
                   {:name => 'name'},
                   {:name => 'description'},
                   {:name => 'tags', :type => Array},
                   {:name => 'price', :type => 'Price'}
                 ])


Congo::Types::Product.delete_all

euro = Congo::Types::Currency.new(:name => 'Euro', :symbol => '€', :code => 'EUR', :format => '#{amount}€')

Congo::Types::Product.create(:name => 'Mighty mouse',
                             :description => 'Crappy mouse from Apple',
                             :tags => ['apple', 'mouse', 'bad'],
                             :price => Congo::Types::Price.new(:amount => 49, :currency => euro))

Congo::Types::Product.create(:name => 'iMac',
                             :description => 'Nice intel computer from Apple',
                             :tags => ['apple', 'intel', 'good'],
                             :price => Congo::Types::Price.new(:amount => 899, :currency => euro))

Congo::Types::Product.create(:name => 'iPod touch',
                             :description => 'Nice mp3 and video player with lots of applications',
                             :tags => ['apple', 'mp3', 'video', 'big'],
                             :price => Congo::Types::Price.new(:amount => 199, :currency => euro))