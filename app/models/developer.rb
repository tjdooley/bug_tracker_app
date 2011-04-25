class Developer < ActiveRecord::Base
  has_many :bugs

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

end
