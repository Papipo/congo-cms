db = MongoMapper.connection.db(Rails.configuration.database_configuration[RAILS_ENV]['database'])
db.collection_names.each do |collection|
  next if collection == 'system.indexes'
  db.collection(collection).clear
end

website = Website.create!(:name => 'My website', :domains => [{:name => 'mywebsite.dev'}])

website.custom_types.create!(:name => 'Currency', :embedded => true,
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

website.custom_types.create!(:name => 'Price', :embedded => true,
                   :keys => [
                     {:name => 'amount',   :type => 'Float' },
                     {:name => 'currency', :type => 'Currency'}
                   ],
                   :validations => [
                      {:type => 'presence_of', :key => 'amount'},
                      {:type => 'presence_of', :key => 'currency'}
                    ])

website.custom_types.create!(:name => 'Product', :embedded => false,
                   :keys => [
                     {:name => 'name'},
                     {:name => 'description'},
                     {:name => 'tags', :type =>  'Array'},
                     {:name => 'price', :type => 'Price'}
                   ],
                   :validations => [
                      {:type => 'presence_of', :key => 'name'},
                      {:type => 'presence_of', :key => 'price'}
                    ])


euro = {:name => 'Euro', :symbol => '€', :code => 'EUR', :format => '#{amount}€'}

website.products.create!(:name => 'Mighty mouse',
                             :description => 'Crappy mouse from Apple',
                             :tags => ['apple', 'mouse', 'bad'],
                             :price => {:amount => 49, :currency => euro})

website.products.create!(:name => 'iMac',
                             :description => 'Nice intel computer from Apple',
                             :tags => ['apple', 'intel', 'good'],
                             :price => {:amount => 899, :currency => euro})

website.products.create!(:name => 'iPod touch',
                             :description => 'Nice mp3 and video player with lots of applications',
                             :tags => ['apple', 'mp3', 'video', 'big'],
                             :price => {:amount => 199, :currency => euro})

website.custom_types.create!(:name => 'Address', :embedded => true,
                   :keys => [
                     {:name => 'street'},
                     {:name => 'city'},
                     {:name => 'zipcode'}
                   ])
                   
website.custom_types.create!(:name => 'Customer', :embedded => false,
                   :keys => [
                     {:name => 'firstname'},
                     {:name => 'lastname'},
                     {:name => 'age', :type => 'Integer'}
                   ],
                   :associations => [
                     {:name => :addresses}
                   ])

website.customers.create!(:firstname => 'John',
                              :lastname  => 'Doe',
                              :age       => 45,
                              :addresses => [
                                {:street => 'My home', :city => 'My city', :zipcode => 'My zipcode'},
                                {:street => 'Another home', :city => 'Another city', :zipcode => 'Another zipcode'}
                              ])

website.custom_types.create!(:name => 'BlogPost', :embedded => false, :timestamps => true,
                   :keys => [
                    {:name => 'title'},
                    {:name => 'body'},
                    {:name => 'tags', :type => 'Array'}
                   ])

website.blog_posts.create!(:title => 'My very first congo blog post',
                              :body  => 'Welcome to the awesome world of dynamic typed content management frameworks...',
                              :tags  => %w{congo cms welcome})

another_website = Website.create!(:name => 'Another website', :domains => [{:name => 'anothersite.dev'}])
blog_post_type = another_website.custom_types.create!(:name => 'BlogPost', :embedded => false, :timestamps => true,
                   :keys => [
                    {:name => 'title'},
                    {:name => 'body'},
                    {:name => 'tags', :type => 'Array'}
                   ])

blog_section = another_website.sections.create!(:path => 'blog', :custom_type => blog_post_type)
template_content = <<-RADIUS
<r:all>
  <h1><r:title /></h1>
  <div><r:body /></div>
</r:all>
RADIUS
blog_section.templates.create!(:content => template_content, :name => 'index')


another_website.blog_posts.create!(:title => 'Another fancy blog post',
                              :body  => 'This stuff is taking shape...',
                              :tags  => %w{second website})