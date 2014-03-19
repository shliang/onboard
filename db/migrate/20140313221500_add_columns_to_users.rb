class AddColumnsToUsers < ActiveRecord::Migration
  def change
    # Just for me
    add_column :users, :provider,    :string
    add_column :users, :uid,         :string
    add_column :users, :name,        :string
    add_column :users, :username,    :string
    add_column :users, :nickname,    :string
    add_column :users, :location,    :string
    add_column :users, :image_url,   :string
    add_column :users, :description, :string
  end
end
