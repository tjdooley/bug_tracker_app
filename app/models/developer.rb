class Developer < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :destroyed
  has_many :bugs

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  before_destroy :check_associated_bugs
  after_destroy :mark_as_destroyed

  

  private
    def check_associated_bugs
      bugs.find_by_developer_id(id) == nil
    end

    def mark_as_destroyed
      self.destroyed = true
    end

end
