class Relationship < ActiveRecord::Base
  belongs_to :principal, class_name: 'User'
  belongs_to :custodian1, class_name: 'User'
  belongs_to :custodian2, class_name: 'User'
  belongs_to :custodian3, class_name: 'User'

    validates :principal_id, presence: true,
                uniqueness: true
end
