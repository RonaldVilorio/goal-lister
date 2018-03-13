class CreateTableGoalSubgoalTable < ActiveRecord::Migration[5.1]
  def change
    create_table :goal_subgoals do |t|
      t.integer :goal_id
      t.integer :subgoal_id
    end

  end
end
