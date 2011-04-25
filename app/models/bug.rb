class Bug < ActiveRecord::Base

  validates :description, :presence => true, 
                          :length => { :maximum => 200 }
  validates :status,  :presence => true,
                      :length   => { :maximum => 50 }
  validates :developer_id,  :presence => true
end
