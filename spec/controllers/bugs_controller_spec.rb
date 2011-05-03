require 'spec_helper'

describe BugsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a title field" do
      get :new
      response.should have_selector("input[name='bug[title]'][type='text']")
    end

    it "should have a description field" do
      get :new
      response.should have_selector("input[name='bug[description]'][type='text']")
    end

    it "should have an status field" do
      get :new
      response.should have_selector("select[name='bug[status]']")
    end

    it "should have a developer field" do
      get :new
      response.should have_selector("select[name='bug[developer_id]']")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :description => "", :status => "", :developer_id => ""}
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
        @attr = { :title => "Test title", :description => "Test description", :status => "Open",
                  :developer_id => 1 }
      end

      it "should create a bug" do
        lambda do
          post :create, :bug => @attr
        end.should change(Bug, :count).by(1)
      end

      it "should redirect to the bug show page" do
        post :create, :bug => @attr
        response.should redirect_to(bug_path(assigns(:bug)))
      end   
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @developer = Factory(:developer)
      @bug = Factory(:bug)
    end

    it "should be successful" do
      get :show, :id => @bug
      response.should be_success
    end

    it "should find the right bug" do
      get :show, :id => @bug
      assigns(:bug).should == @bug
    end

    it "should include the bug's title" do
      get :show, :id => @bug
      response.should have_selector("td", :content => @bug.title)
    end

    it "should include the bug's description" do
      get :show, :id => @bug
      response.should have_selector("td", :content => @bug.description)
    end

    it "should include the bug's status" do
      get :show, :id => @bug
      response.should have_selector("td", :content => @bug.status)
    end

    it "should have a link to the bug's developer" do
      get :show, :id => @bug
      developer_url = "/developers/1"
      response.should have_selector("a", :href => developer_url,
                                         :content => @developer.name)
    end
  end

  describe "GET 'index'" do

    before(:each) do
      @developer = Factory(:developer)
      @bug = Factory(:bug)
      second = Factory(:bug, :title => "Test title", :description => "Second Bug", :status => "Closed", :developer_id => "1")
      third  = Factory(:bug, :title => "Test title", :description => "Third Bug", :status => "New", :developer_id => "1")

      @bugs = [@bug, second, third]
      30.times do
        @bug = Factory(:bug, :description => Factory.next(:description))
      end

    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each bug" do
      get :index
      @bugs.each do |bug|
        response.should have_selector("td", :content => bug.title)
      end
    end

    it "should have an element for each bug" do
      get :index
      @bugs[0..2].each do |bug|
        response.should have_selector("td", :content => bug.title)
      end
    end

    it "should paginate bugs" do
      get :index
      response.should have_selector("a", :href => "/bugs?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/bugs?page=2",
                                         :content => "Next")
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @bug = Factory(:bug)
    end

    it "should destroy the bug" do
      lambda do
        delete :destroy, :id => @bug
      end.should change(Bug, :count).by(-1)
    end

    it "should redirect to the bugs page" do
      delete :destroy, :id => @bug
      response.should redirect_to(bugs_path)
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @bug = Factory(:bug)
    end

    it "should be successful" do
      get :edit, :id => @bug
      response.should be_success
    end

    it "should have a title field" do
      get :edit, :id => @bug
      response.should have_selector("input[name='bug[title]'][type='text']")
    end

    it "should have a description field" do
      get :edit, :id => @bug
      response.should have_selector("input[name='bug[description]'][type='text']")
    end

    it "should have an status field" do
      get :edit, :id => @bug
      response.should have_selector("select[name='bug[status]']")
    end

    it "should have a developer field" do
      get :edit, :id => @bug
      response.should have_selector("select[name='bug[developer_id]']")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @bug = Factory(:bug)
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :description => "", :status => "", :developer_id => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @bug, :bug => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @bug, :bug => @attr
        response.should have_selector("h1", :content => "Edit bug")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "Test title", :description => "Test bug description", :status => "New", :developer_id => 1 }
      end

      it "should change the bug's attributes" do
        put :update, :id => @bug, :bug => @attr
        @bug.reload
        @bug.title.should  == @attr[:title]
        @bug.description.should  == @attr[:description]
        @bug.status.should == @attr[:status]
        @bug.developer_id.should == @attr[:developer_id]
      end

      it "should redirect to the bug's show page" do
        put :update, :id => @bug, :bug => @attr
        response.should redirect_to(bug_path(@bug))
      end

      it "should have a flash message" do
        put :update, :id => @bug, :bug => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

end
