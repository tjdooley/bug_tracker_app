require 'spec_helper'

describe Bug do
  
  before(:each) do
    @attr = { 
      :description => "Test bug description",
      :status => "Open",
      :developer_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Bug.create!(@attr)
  end

  it "should require a description" do 
    no_description_bug = Bug.new(@attr.merge(:description => ""))
    no_description_bug.should_not be_valid
  end

  it "should require a status" do 
    no_description_bug = Bug.new(@attr.merge(:status => ""))
    no_description_bug.should_not be_valid
  end

  it "should require a developer id" do 
    no_description_bug = Bug.new(@attr.merge(:status => ""))
    no_description_bug.should_not be_valid
  end

  it "should reject descriptions that are too long" do
    long_description = "a" * 201
    long_description_bug = Bug.new(@attr.merge(:description => long_description))
    long_description_bug.should_not be_valid
  end

  it "should reject status that are too long" do
    long_status = "a" * 201
    long_status_bug = Bug.new(@attr.merge(:description => long_status))
    long_status_bug.should_not be_valid
  end

end
