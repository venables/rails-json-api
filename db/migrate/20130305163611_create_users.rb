class CreateUsers < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.datetime :last_login_at, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
