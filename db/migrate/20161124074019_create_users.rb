class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :is_admin , default: false
      t.timestamps
    end
  end
end
