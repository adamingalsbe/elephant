class Relationship < ActiveRecord::Base
  belongs_to :principal, class_name: 'User'
  belongs_to :custodian, class_name: 'User'

    validates :principal_id, presence: true
    validates :custodian_id, presence: true
end
