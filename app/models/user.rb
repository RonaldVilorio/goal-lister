class User < ActiveRecord::Base
has_many :goals
has_many :subgoals, through: :goals
end
