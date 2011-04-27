require 'spec_helper'

describe DevelopersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='developer[name]'][type='text']")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
      end

      it "should not create a developer" do
        lambda do
          post :create, :developer => @attr
        end.should_not change(Developer, :count)
      end

      it "should render the 'new' page" do
        post :create, :developer => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Jim Developer" }
      end

      it "should create a developer" do
        lambda do
          post :create, :developer => @attr
        end.should change(Developer, :count).by(1)
      end

    end
  end

end
