class Bug < ActiveRecord::Base
  attr_accessible :title, :description, :status, :developer_id

  validates :title, :presence => true, 
                          :length => { :maximum => 50 }
  validates :description, :presence => true, 
                          :length => { :maximum => 200 }
  validates :status,  :presence => true,
                      :length   => { :maximum => 50 }
  validates :developer_id,  :presence => true
end
