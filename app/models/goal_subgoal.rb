class GoalsSubgoal < ActiveRecord::Base
  belongs_to :goal
  belongs_to :subgoal
end
