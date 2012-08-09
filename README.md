# Seeding

Seeding is a seed.rb generator for lazy and/or smart people. I had to create seed files for all sorts of projects but in most cases I had to create them based on conditions etc. Like "Hey, can you create a seed.rb which includes all customers which are marked with 'Demo'?"

Seeding makes it super easy. It needs to have access to your ActiveRecord models and therefore it's best to use it with 'rails c'. I am happy to extend it for other use cases if needed. 

## Installation

Add this line to your application's Gemfile:

    gem 'seeding'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install seeding

## Usage

1. Switch to your rails app folder
2. Add "gem 'seeding'" to your Gemfile
3. enter bundle on the shell
4. Start your rails console by "rails c" or pass an Environment to it  
You can pass in any model and/or query as you see fit... 
Examples:  
`Seeding::CreateSeed.new.query { MyModel.where("id < 10000") }`  
`Seeding::CreateSeed.new.query { User.where(test: true)}`
`Seeding::CreateSeed.new.query { Category.all(:order => "name desc") }`
`Seeding::CreateSeed.new.query { Category.all(:order => "name desc", :select => "id, name, country,") }`

It then creates a file in the root directory in your application named seeding-MyModel + guid sequence to prevent accidentally overwriting

Example:  
`1.9.3p0 :001 > Seeding::CreateSeed.new.query { Category.all(:order => "name desc", :select => "id, name, country, catgroup") }`

creates:  
seeding-Category-604a68a0-c3f4-012f-fcf7-482a14164364.rb  

Which looks basically like this:  

# -*- encoding: utf-8 -*-
Category.create!  :id => 324,  :name => 'Zoohandlungen ',  :country => 'de',  :catgroup => 'Einkaufen'  
puts "."  
Category.create!  :id => 288,  :name => 'Zeitungen und Zeitschriften',  :country => 'de',  :catgroup => 'Werbung & Medien'  
puts "."  
Category.create!  :id => 76,  :name => 'Zeitarbeit',  :country => 'de',  :catgroup => 'Bildung & Beruf'  
puts "."  
Category.create!  :id => 107,  :name => 'Zahnmedizin',  :country => 'de',  :catgroup => 'Gesundheit'  
puts "."  
Category.create!  :id => 229,  :name => 'Yoga ',  :country => 'de',  :catgroup => 'Beauty & Wellness'  
puts "."  
Category.create!  :id => 52,  :name => 'Wohnungs- und Zimmervermittlung ',  :country => 'de',  :catgroup => 'Öffentliches & Soziales'  

... and so on....

The puts "." is pretty lame I admit but it's just nice to see that there are still rows written which is indicated by all these dots. If anything, this is better than writing seeds files by hand:-) 



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
