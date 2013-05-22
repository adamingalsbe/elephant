class Bank < ActiveRecord::Base
  attr_accessible :name, :notes
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 3 }
end
