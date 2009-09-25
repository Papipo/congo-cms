db = MongoMapper.connection.db(Rails.configuration.database_configuration[RAILS_ENV]['database'])
db.collection_names.each do |collection|
  db.collection(collection).clear
end

DynamicType.create(:id => 'Currency', :embedded => true,
                   :keys => [
                     {:name => 'name'},
                     {:name => 'code'},
                     {:name => 'symbol'}
                   ],
                   :validations => [
                     {:type => 'presence_of', :key => 'name'},
                     {:type => 'presence_of', :key => 'code'},
                     {:type => 'presence_of', :key => 'symbol'}
                   ])

DynamicType.create(:id  => 'Price', :embedded => true,
                   :keys => [
                     {:name => 'amount',   :type => 'Float' },
                     {:name => 'currency', :type => 'Currency'}
                   ],
                   :validations => [
                      {:type => 'presence_of', :key => 'amount'},
                      {:type => 'presence_of', :key => 'currency'}
                    ])

DynamicType.create(:id => 'Product', :embedded => false,
                   :keys => [
                     {:name => 'name'},
                     {:name => 'description'},
                     {:name => 'tags', :type => Array},
                     {:name => 'price', :type => 'Price'}
                   ],
                   :validations => [
                      {:type => 'presence_of', :key => 'name'},
                      {:type => 'presence_of', :key => 'price'}
                    ])


euro = {:name => 'Euro', :symbol => '€', :code => 'EUR', :format => '#{amount}€'}

Congo::Types::Product.create(:name => 'Mighty mouse',
                             :description => 'Crappy mouse from Apple',
                             :tags => ['apple', 'mouse', 'bad'],
                             :price => {:amount => 49, :currency => euro})

Congo::Types::Product.create(:name => 'iMac',
                             :description => 'Nice intel computer from Apple',
                             :tags => ['apple', 'intel', 'good'],
                             :price => {:amount => 899, :currency => euro})

Congo::Types::Product.create(:name => 'iPod touch',
                             :description => 'Nice mp3 and video player with lots of applications',
                             :tags => ['apple', 'mp3', 'video', 'big'],
                             :price => {:amount => 199, :currency => euro})
                             
DynamicType.create(:id => 'BlogPost', :embedded => false, :timestamps => true,
                   :keys => [
                    {:name => 'title'},
                    {:name => 'body'},
                    {:name => 'tags', :type => 'Array'}
                   ])
                   
Congo::Types::BlogPost.create(:title => 'My very first congo blog post',
                              :body  => 'Welcome to the awesome world of dynamic typed content management frameworks...',
                              :tags  => %w{congo cms welcome})