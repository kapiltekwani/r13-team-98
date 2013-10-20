FactoryGirl.define do
  factory :user do
    sequence(:name) { Faker::Name.first_name }
    password 'josh123'
    provider 'facebook'
    sequence(:uid) { rand(1000000000000) }  

    after(:create) do |u|
      user = User.create!({name: Faker::Name.first_name, uid: rand(100000000000), friend_ids: u.uid})
      u.friend_ids = [user.uid]
      u.save
    end
  end
end
