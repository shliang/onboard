FactoryGirl.define do
  factory :user do
    email {FactoryGirl.generate :email}
    password 'changeme9'
    password_confirmation { password }
    confirmed_at Time.now
  end
end