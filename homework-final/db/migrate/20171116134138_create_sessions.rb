class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :key
      t.integer :user_id

      t.timestamps
    end
  end
end
