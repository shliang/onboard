class User < ActiveRecord::Base
  devise :confirmable, :database_authenticatable, :lockable, :omniauthable, :registerable, :rememberable, :trackable, :validatable
  # other Devise modules--  :recoverable, :timeoutable

end
