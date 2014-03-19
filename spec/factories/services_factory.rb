FactoryGirl.define do
  factory :service do
    provider 'facebook'
    uid {FactoryGirl.generate :uid}
  end
end
