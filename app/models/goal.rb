class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goal_subgoals
  has_many :subgoals, through: :goal_subgoals

end
