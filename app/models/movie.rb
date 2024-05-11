class Movie < ActiveRecord::Base
  validates :director, presence: false
end
