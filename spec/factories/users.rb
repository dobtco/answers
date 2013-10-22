# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    profile {
      [
        { "name" => 'Adam Becker', "email" => "adam@dobt.co", 'image_url' => 'http://www.gravatar.com/avatar/9b335f8228dbbf55711ba32bab4cd591?s=200&d=identicon' },
        { "name" => 'Sid Burgess', "email" => "sid@dobt.co", 'image_url' => 'http://www.gravatar.com/avatar/a2ba0551e76bdaee9ee5ed63166efdef?s=200&d=identicon' },
        { "name" => 'Clay Johnson', "email" => "clay@dobt.co", 'image_url' => 'http://i.imgur.com/UBJTsPL.png' },
        { "name" => 'Ben Balter', "email" => "ben@balter.com", 'image_url' => 'http://www.gravatar.com/avatar/ea353bd28baa1aefaefae736a19fcf2a?s=200&d=identicon' },
        { "name" => 'Lauren Beato', "email" => "lauren@example.com", 'image_url' => 'http://i.imgur.com/OqDvY0e.jpg' },
        { "name" => 'Jonah Silver', "email" => "jonah@example.com", 'image_url' => 'http://i.imgur.com/1fj339M.jpg' },
        { "name" => 'Mollie Townsend', "email" => "mollie@example.com", 'image_url' => 'http://i.imgur.com/3BkwBU8.jpg' },
        { "name" => 'Sarah Snyder', "email" => "sarah@example.com", 'image_url' => 'http://i.imgur.com/pgvmRLl.jpg' }
      ].sample
    }
  end
end
