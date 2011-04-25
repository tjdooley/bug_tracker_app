class Developer < ActiveRecord::Base
  has_many :bugs

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  before_destroy :check_associated_bugs

  private
    def check_associated_bugs
      bugs.find_by_developer_id(id) == nil
    end

end
