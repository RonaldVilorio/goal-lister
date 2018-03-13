class Subgoal < ActiveRecord::Base
  has_many :goals_subgoals
  has_many :goals, through: :goals_subgoals
  has_many :users, through: :goals
end
