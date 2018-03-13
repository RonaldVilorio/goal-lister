class CreateTableGoalSubgoalTable < ActiveRecord::Migration[5.1]
  def change
    create_table :goal_subgoals do |t|
      t.integer :goals_id
      t.integer :subgoals_id
    end

  end
end
