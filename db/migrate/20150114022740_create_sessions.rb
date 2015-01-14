class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :token, null: false
      t.datetime :expires_at, null: false
      t.inet :ip_address, null: false
      t.text :user_agent, null: false

      t.timestamps null: false
    end

    add_foreign_key :sessions, :users
    add_index :sessions, :user_id
    add_index :sessions, :token, unique: true
  end
end
