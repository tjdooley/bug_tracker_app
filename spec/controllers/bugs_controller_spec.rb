require 'spec_helper'

describe BugsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a description field" do
      get :new
      response.should have_selector("input[name='bug[description]'][type='text']")
    end

    it "should have an status field" do
      get :new
      response.should have_selector("input[name='bug[status]'][type='text']")
    end

    it "should have a developer field" do
      get :new
      response.should have_selector("select[name='bug[developer_id]']")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :description => "", :status => "", :developer_id => ""}
      end

      it "should not create a bug" do
        lambda do
          post :create, :bug => @attr
        end.should_not change(Bug, :count)
      end

      it "should render the 'new' page" do
        post :create, :bug => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :description => "Test description", :status => "Open",
                  :developer_id => 1 }
      end

      it "should create a bug" do
        lambda do
          post :create, :bug => @attr
        end.should change(Bug, :count).by(1)
      end

      #it "should redirect to the bug show page" do
      #  post :create, :bug => @attr
      #  response.should redirect_to(bug_path(assigns(:bug)))
      #end   

 
    end
  end

end
