class User < ActiveRecord::Base
  include Concerns::Slugify
  extend Concerns::Findable
  has_secure_password
  has_many :goals
  has_many :subgoals, through: :goals
end
