class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string  :uid
      t.string  :provider
      t.string  :token
      t.string  :secret
      t.text    :info
      t.integer :user_id

      t.timestamps
    end
  end
end
