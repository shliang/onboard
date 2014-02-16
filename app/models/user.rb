class User < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :omniauthable, :rememberable, :trackable, :validatable
  # other Devise modules--  :confirmable, :registerable, :recoverable, :timeoutable

end
