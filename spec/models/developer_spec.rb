require 'spec_helper'

describe Developer do
  
  before(:each) do
    @attr = { 
      :name => "Test developer"
    }
  end

  it "should create a new instance given valid attributes" do
    Developer.create!(@attr)
  end

  it "should require a name" do 
    no_name_developer = Developer.new(@attr.merge(:name => ""))
    no_name_developer.should_not be_valid
  end

  it "should reject names that are too long" do
    long_developer = "a" * 201
    long_developer = Developer.new(@attr.merge(:name => long_developer))
    long_developer.should_not be_valid
  end

  it "should not destroy a developer assigned to a bug" do
    developer = Developer.create!(@attr)
    bug = Bug.create!(:title => "Title", :description => "Test bug description", :status => "Open", :developer_id => developer.id)
    developer.destroy
    developer.should_not be_destroyed
  end

end
