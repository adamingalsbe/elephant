# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  email_address :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :first_name, :last_name, :email_address, :password, :password_confirmation
  has_many :banks
  has_many :principal_relationships, class_name: 'Relationship', foreign_key: 'principal_id'
  has_many :custodian_relationships, class_name: 'Relationship', foreign_key: 'custodian_id'
def relationships
  Relationship.where("principal_id = #{self.id} OR custodian_id = #{self.id}")
end

  before_save { |user| user.email_address = email_address.downcase }
  validates :first_name, presence: true, length: {minimum: 2, maximum: 50}
  validates :last_name, presence: true, length: {minimum: 2, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, presence: true,
                format: { with: VALID_EMAIL_REGEX},
                uniqueness: {case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6}
  validates :password_confirmation, presence: true
end
