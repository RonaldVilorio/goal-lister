class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goals_subgoals
  has_many :subgoals, through: :goals_subgoals

end
