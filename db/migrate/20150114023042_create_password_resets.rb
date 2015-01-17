class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :token, null: false
      t.datetime :expires_at, null: false

      t.timestamps null: false
    end

    add_foreign_key :password_resets, :users
    add_index :password_resets, :token, unique: true
  end
end
