class Bill < ActiveRecord::Base
  attr_accessible :autopay, :name, :notes
end
