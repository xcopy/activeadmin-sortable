class Thing < ActiveRecord::Base
  attr_accessible :name, :position

  acts_as_list
end
