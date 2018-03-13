class Subgoal < ActiveRecord::Base
  has_many :goal_subgoals
  has_many :goals, through: :goal_subgoals
  has_many :users, through: :goals
end
