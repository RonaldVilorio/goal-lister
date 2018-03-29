class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goal_subgoals
  has_many :subgoals, through: :goal_subgoals
  validates_uniqueness_of :content

  def create_subgoals(subgoals)
    subgoals.each do |key,sgoal|
      sgoal = sgoal.strip
      if !sgoal.empty?
        self.subgoals << Subgoal.create(content: sgoal)
        self.save
      elsif sgoal.empty?
        flash[:message] = "You can't submit empty subgoals"
        redirect "/goals/new"
      end
    end
  end



end
