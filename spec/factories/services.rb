# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    provider ""
    uid ""
    token ""
    secret ""
    info "MyString"
  end
end
