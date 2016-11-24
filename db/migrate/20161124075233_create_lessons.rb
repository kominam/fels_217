class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.references :category, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
