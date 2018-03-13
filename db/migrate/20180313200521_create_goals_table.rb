class CreateGoalsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
