class CreateSubgoalsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :subgoals do |t|
      t.string :content
    end
  end
end
