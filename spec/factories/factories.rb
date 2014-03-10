FactoryGirl.define do
  ###
  ## => Shared sequence
  ###
  sequence(:line1) {|n| "#{n} Harrison Street"}
  sequence(:line2) {|n| "Apt #{n}"}
  sequence(:locality) {|n| "#{n.ordinalize} Circle of Hezmana"}
  sequence(:company) {|n| "The #{n} FishShaped Dren Company"}
  sequence(:email) {|n| "B#{n}ob@fish.dren"}
  sequence(:first_name) {|n| "Bo#{n}b"}
  sequence(:last_name) {|n| "Johnson#{n}"}
  sequence(:number) {|n| "#{n}"}
  sequence(:postal_usa) {|n| "#{n.to_s.rjust(5, '0')}"}
end